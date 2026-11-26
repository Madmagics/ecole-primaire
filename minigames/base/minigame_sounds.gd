## Petit synthetiseur pour les mini-jeux (2026-11-25) : notes de musique et bruitages fabriques
## en code (AudioStreamWAV 16 bits genere une fois puis garde en cache), donc aucun fichier son a
## ajouter au projet. Tout passe par SoundManager.play_stream() : bus "Bruitages", le curseur de
## volume des bruitages et le mute s'appliquent donc aussi a ces sons.
class_name MiniGameSounds
extends RefCounted

enum Wave { SINE, TRIANGLE, SQUARE, NOISE }

const MIX_RATE := 22050
const ATTACK_SECONDS := 0.005
const AMPLITUDE := 30000.0

## Notes utiles (Hz).
const C5 := 523.25
const D5 := 587.33
const E5 := 659.25
const G5 := 783.99
const A5 := 880.0
const C6 := 1046.5
const E6 := 1318.51
const G6 := 1567.98
const C7 := 2093.0

static var _cache: Dictionary[String, AudioStreamWAV] = {}

## Joue un son : [freq] en Hz, glisse jusqu'a [end_freq] si > 0 (effets "boing", "pop"...).
static func play_tone(freq: float, seconds: float = 0.3, wave: Wave = Wave.TRIANGLE, volume_db: float = -4.0, end_freq: float = 0.0) -> void:
	SoundManager.play_stream(get_tone(freq, seconds, wave, end_freq), volume_db)

## Joue les notes [freqs] l'une apres l'autre, espacees de [gap] secondes, apres [delay].
static func play_arpeggio(freqs: Array, gap: float = 0.09, delay: float = 0.0, volume_db: float = -6.0) -> void:
	var tree := SoundManager.get_tree()
	for index in freqs.size():
		var freq: float = freqs[index]
		var wait := delay + gap * index
		if wait <= 0.0:
			play_tone(freq, 0.3, Wave.TRIANGLE, volume_db)
		else:
			tree.create_timer(wait).timeout.connect(func() -> void: play_tone(freq, 0.3, Wave.TRIANGLE, volume_db))

static func get_tone(freq: float, seconds: float, wave: Wave, end_freq: float = 0.0) -> AudioStreamWAV:
	var key := "%s|%s|%d|%s" % [freq, seconds, wave, end_freq]
	if _cache.has(key):
		return _cache[key]
	var count := int(seconds * MIX_RATE)
	var attack := ATTACK_SECONDS * MIX_RATE
	var target := end_freq if end_freq > 0.0 else freq
	var data := PackedByteArray()
	data.resize(count * 2)
	var phase := 0.0
	for i in count:
		var t := float(i) / float(count)
		phase = fposmod(phase + lerpf(freq, target, t) / MIX_RATE, 1.0)
		var sample := 0.0
		match wave:
			Wave.SINE:
				sample = sin(phase * TAU)
			Wave.TRIANGLE:
				sample = 1.0 - 4.0 * absf(phase - 0.5)
			Wave.SQUARE:
				sample = 0.5 if phase < 0.5 else -0.5
			Wave.NOISE:
				sample = randf_range(-0.6, 0.6)
		## Attaque tres courte (pas de "clic") puis extinction progressive.
		var envelope := minf(1.0, float(i) / attack) * pow(1.0 - t, 1.6)
		data.encode_s16(i * 2, int(clampf(sample * envelope, -1.0, 1.0) * AMPLITUDE))
	var stream := AudioStreamWAV.new()
	stream.format = AudioStreamWAV.FORMAT_16_BITS
	stream.mix_rate = MIX_RATE
	stream.data = data
	_cache[key] = stream
	return stream
