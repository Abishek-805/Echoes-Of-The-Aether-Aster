"""Original layered pixel-art draft; no downloaded sprites or image edits.
Rebuild: python tools/build_slice_art.py. Pillow only. Palette locked below.
"""
from pathlib import Path
from PIL import Image, ImageDraw
import math, random, json

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'art/runtime'
SRC = ROOT / 'art/source'
PRE = ROOT / 'art/previews'
for p in (OUT, SRC, PRE):
    p.mkdir(parents=True, exist_ok=True)
P = dict(ink='#111b2a', dark='#243447', cloth='#3c5865', blue='#638291',
         silver='#a6b8ad', light='#e2dcc2', skin='#c58d65', face='#e5b58b',
         hair='#342e35', hairlight='#665047', bronze='#91704f', gold='#c5a572',
         green='#486955', moss='#829c6a', cyan='#56cdc4', glow='#aff5dc',
         soil='#394337', water='#284d59', far='#243d46', sky='#182d3b')
(SRC / 'palette.json').write_text(json.dumps(P, indent=2))

def blank(w=48,h=56): return Image.new('RGBA',(w,h))
def hero(action, f, count):
    layers={name:blank() for name in ['pack','leg_far','arm_far','torso','leg_near','head','arm_near','weapon']}
    stride=round(math.sin(f/count*math.tau)*4) if action=='run' else 0
    bob=1 if action=='idle' and f in (1,2) else 0
    if action=='run': bob=-(f%2)
    def rect(layer,xy,color): ImageDraw.Draw(layers[layer]).rectangle(xy,fill=P[color])
    def poly(layer,xy,color): ImageDraw.Draw(layers[layer]).polygon(xy,fill=P[color])
    rect('pack',(9,20+bob,17,36+bob),'ink');rect('pack',(10,21+bob,16,34+bob),'bronze')
    rect('pack',(11,23+bob,14,30+bob),'gold');rect('pack',(10,32+bob,16,33+bob),'dark')
    for layer,dx in [('leg_far',-stride+3),('leg_near',stride-2)]:
        color='dark' if layer=='leg_far' else 'cloth'
        poly(layer,[(18,35+bob),(24,35+bob),(24+dx,47),(26+dx,50),(16+dx,50),(16+dx,46)],'ink')
        poly(layer,[(19,36+bob),(23,36+bob),(22+dx,45),(17+dx,46)],color)
        rect(layer,(18+dx,46,25+dx,48),'dark');rect(layer,(18+dx,49,26+dx,50),'silver')
    poly('arm_far',[(23,23+bob),(28,24+bob),(30,35+bob),(26,36+bob),(23,29+bob)],'dark')
    poly('torso',[(16,20+bob),(25,20+bob),(28,27+bob),(26,37+bob),(16,37+bob),(14,26+bob)],'ink')
    poly('torso',[(17,21+bob),(24,21+bob),(26,27+bob),(24,35+bob),(17,35+bob),(16,26+bob)],'cloth')
    rect('torso',(17,22+bob,19,34+bob),'blue');rect('torso',(19,22+bob,22,24+bob),'gold')
    rect('torso',(17,35+bob,25,37+bob),'bronze');rect('torso',(20,35+bob,22,36+bob),'gold')
    rect('torso',(22,26+bob,25,30+bob),'ink');rect('torso',(23,27+bob,24,29+bob),'cyan')
    poly('head',[(17,9+bob),(24,8+bob),(28,13+bob),(27,20+bob),(22,22+bob),(17,19+bob)],'ink')
    poly('head',[(19,11+bob),(25,11+bob),(27,15+bob),(26,19+bob),(22,20+bob),(19,18+bob)],'skin')
    rect('head',(23,13+bob,26,17+bob),'face');rect('head',(25,14+bob,26,14+bob),'ink')
    poly('head',[(16,13+bob),(15,10+bob),(18,9+bob),(18,7+bob),(21,8+bob),(24,6+bob),(26,9+bob),(28,10+bob),(27,13+bob),(22,11+bob),(20,15+bob),(18,15+bob)],'hair')
    rect('head',(19,9+bob,23,10+bob),'hairlight')
    if action=='blade':
        swing=[-4,0,8,12,8,2][f]
        poly('arm_near',[(17,23+bob),(21,23+bob),(27,27+bob),(31,26+bob+swing//4),(32,30+bob+swing//4),(25,32+bob),(17,28+bob)],'blue')
        poly('weapon',[(29,27+swing//4),(39,18+swing),(41,20+swing),(32,30+swing//4)],'silver')
    else:
        poly('arm_near',[(16,23+bob),(20,22+bob),(23,29+bob),(30,30+bob),(30,33+bob),(20,33+bob),(16,28+bob)],'ink')
        poly('arm_near',[(17,24+bob),(20,24+bob),(22,30+bob),(28,31+bob),(28,32+bob),(20,31+bob)],'blue')
        rect('weapon',(27,27+bob,40,31+bob),'ink');rect('weapon',(29,28+bob,40,29+bob),'silver')
        rect('weapon',(30,30+bob,34,31+bob),'bronze');rect('weapon',(35,29+bob,38,29+bob),'cyan')
    frame=blank()
    for name,layer in layers.items():
        folder=SRC/'aster'/action/name;folder.mkdir(parents=True,exist_ok=True)
        layer.save(folder/f'{f:02}.png');frame.alpha_composite(layer)
    return frame

all_preview=[]
for action,count in [('idle',4),('run',8),('blade',6)]:
    frames=[hero(action,f,count) for f in range(count)]
    sheet=Image.new('RGBA',(48*count,56))
    for i,frame in enumerate(frames):sheet.paste(frame,(48*i,0))
    sheet.save(OUT/f'aster_{action}.png');all_preview.append((action,sheet))

sheet=Image.new('RGBA',(48*6,32))
for f in range(6):
    im=Image.new('RGBA',(48,32));d=ImageDraw.Draw(im);b=f%2
    for x in (10,18,29,36):d.rectangle((x,23,x+3,28-(f%3)),fill=P['dark'])
    d.polygon([(6,20),(11,12+b),(18,10+b),(23,6+b),(29,11+b),(38,12+b),(42,21),(36,25),(11,25)],fill=P['ink'])
    d.polygon([(8,19),(13,13+b),(21,13+b),(26,10+b),(29,14+b),(38,15+b),(39,21),(32,23),(12,23)],fill=P['bronze'])
    d.polygon([(13,13+b),(19,12+b),(22,15+b),(31,15+b),(33,19),(13,18)],fill=P['gold'])
    d.rectangle((34,17+b,37,18+b),fill=P['cyan']);d.rectangle((7,20,13,21),fill=P['moss'])
    sheet.paste(im,(48*f,0))
sheet.save(OUT/'forager.png');all_preview.append(('forager',sheet))

for family in ['frontier','camp','sluice','arena','rootspan']:
    rng=random.Random(37)
    im=Image.new('RGB',(640,360),P['sky']);d=ImageDraw.Draw(im)
    for i,color in enumerate([P['far'],P['water'],P['dark']]):
        points=[(-20,310)]+[(x,120+i*30+rng.randrange(-35,35)) for x in range(-20,680,35)]+[(660,310)]
        d.polygon(points,fill=color)
    for x in range(-20,680,80):
        y=rng.randrange(70,150)
        d.rectangle((x,y,x+10,308),fill=P['far'])
        d.ellipse((x-50,y-25,x+60,y+30),fill=P['far'])
        d.line((x,y+90,x+40,y+45),fill=P['far'],width=5)
    for x in [30,190,400,550]:
        top=rng.randrange(120,190)
        d.rectangle((x,top,x+23,290),fill=P['dark']);d.rectangle((x+2,top,x+5,288),fill=P['blue'])
        d.rectangle((x-4,top-5,x+29,top+2),fill=P['silver'])
        for y in range(top+15,280,24):d.rectangle((x+10,y,x+14,y+8),fill=P['bronze'])
    if family in ['sluice','arena']:
        d.rectangle((0,255,639,285),fill=P['water'])
        for y in range(259,285,6):
            for x in range(0,640,45):d.line((x+y%13,y,x+20+y%13,y),fill=P['blue'])
        d.line((70,225,570,225),fill=P['bronze'],width=3)
        d.line((70,227,570,227),fill=P['cyan'],width=1)
    if family=='camp':
        d.polygon([(350,285),(390,222),(440,285)],fill=P['bronze'])
        d.polygon([(390,226),(416,285),(379,285)],fill=P['ink'])
        d.rectangle((400,259,435,264),fill=P['gold'])
    for _ in range(240):
        x=rng.randrange(640);y=rng.randrange(285,300)
        d.rectangle((x,y,x+2,y+2),fill=rng.choice([P['green'],P['moss'],P['soil']]))
    im.save(OUT/f'bg_{family}.png')

tile=Image.new('RGBA',(16,16),P['soil']);d=ImageDraw.Draw(tile)
d.rectangle((0,0,15,2),fill=P['moss']);d.rectangle((0,3,15,5),fill=P['green'])
for x,y in [(2,8),(9,7),(5,13),(13,12)]:d.rectangle((x,y,x+2,y+1),fill=P['dark'])
tile.save(OUT/'terrain.png')
preview=Image.new('RGB',(960,560),P['ink']);d=ImageDraw.Draw(preview)
for i,(name,sheet) in enumerate(all_preview):
    d.text((8,i*135+3),name,fill=P['light'])
    preview.paste(sheet.resize((sheet.width*2,sheet.height*2),Image.Resampling.NEAREST),(8,i*135+20),sheet.resize((sheet.width*2,sheet.height*2),Image.Resampling.NEAREST))
preview.save(PRE/'contact_sheet.png')
manifest={'status':'visual draft — needs native-scale review','authoring':'original deterministic Python/Pillow','reference_role':'V2 character and art bibles; older concept inspected but not edited','palette':P,'sprite_size':[48,56],'foot_pivot':[24,51],'files':sorted(p.name for p in OUT.glob('*.png')),'source':'tools/build_slice_art.py','layers':'art/source/aster'}
(SRC/'slice_manifest.json').write_text(json.dumps(manifest,indent=2))
print('Exported layered hero, Forager, five backgrounds and terrain; visual review pending.')
