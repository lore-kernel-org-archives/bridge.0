Message-ID: <BLU136-W369654C2EC452BACC340FBEF6D0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_69c80af7-1ec4-429d-b2c0-c904e57c9078_"
From: Fabian Ischia <f_ischia@hotmail.com>
Date: Fri, 15 Aug 2008 13:26:43 -0400
MIME-Version: 1.0
Subject: [Bridge] Increase on context switches
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--_69c80af7-1ec4-429d-b2c0-c904e57c9078_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I've started using bridges at the office because I need to connect Virtual =
Machines (User-Mode-Linux). I've noticed that it causes a huge increase in =
context switches.
The context switches seem to be limited somehow (I guess some kernel mechan=
ism to prevent going wild). The context switches=2C even though they're che=
ap=2C also account for some 8-10% of CPU.
I've checked with some more knowledgeable people than me and they said in a=
 heavy loaded server I should expect something around 30K but I'm around 1M=
 and that's with the machine just sitting idle.
Does anyone know if there is an actual bug=2C and the appropriate patch to =
fix it=3B or whether it is considered OK this behavior?=20

Fabian

Running vmstat I see:
Without bridges:
  1  0 187312  58088  32144 338636    0    0     0     0  189  997 83  1 17=
  0
 1  0 187312  57948  32144 338636    0    0     0     0  140  576 25  1 74 =
 0
 1  0 187312  58088  32144 338636    0    0     0     0  168  777 83  1 17 =
 0
 1  0 187312  58016  32144 338636    0    0     0     0  154  655 26  1 73 =
 0
 1  0 187312  57960  32144 338636    0    0     0     0  137  500 82  1 17 =
 0
 1  0 187312  58088  32144 338636    0    0     0     0  154  611 25  1 74 =
 0
 1  0 187312  57960  32144 338636    0    0     0     0  135  525 83  1 17 =
 0

With 4 bridges idle (no traffic on the interfaces)
 1  0 187312  50864  32276 338632    0    0     0     0  139 134920 81  4 1=
5  0
 1  0 187312  51012  32276 338632    0    0     0     0  178 145827 24  3 7=
2  0
 1  0 187312  50880  32276 338632    0    0     0    36  180 152482 82  3 1=
6  0
 1  0 187312  50808  32276 338636    0    0     0     0  145 126225 25  2 7=
2  0
 1  0 187312  50888  32284 338628    0    0     0    56  162 136169 82  2 1=
6  0
 1  0 187312  50820  32284 338636    0    0     0     0  207 112448 26  3 7=
1  0
 1  0 187312  50740  32284 338636    0    0     0     0  148 163085 82  4 1=
5  0

The precedent metrics are from my desktop machine=2C on the actual host whe=
re I have more bridges.
 0  0      0 679748  34448 2404840    0    0     0     0   67 928669  3 10 =
86  0
 0  0      0 679748  34448 2404840    0    0     0     0   89 884379  2  9 =
90  0
 0  0      0 679748  34448 2404840    0    0     0     0   66 924828  2 10 =
88  0
 0  0      0 679748  34456 2404840    0    0     0     4   67 906076  5  8 =
87  0
 0  0      0 679748  34456 2404840    0    0     0     0   67 920194  1  9 =
91  0
 0  0      0 679748  34456 2404840    0    0     0     0   89 905816  1  11=
 91  0
 0  0      0 679748  34464 2404840    0    0     0     0   87 868858  3  10=
 91  0


_________________________________________________________________


--_69c80af7-1ec4-429d-b2c0-c904e57c9078_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
FONT-SIZE: 10pt=3B
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class=3D'hmmessage'><div style=3D"text-align: left=3B">I've started u=
sing bridges at the office because I need to connect Virtual Machines (User=
-Mode-Linux). I've noticed that it causes a huge increase in context switch=
es.<br>The context switches seem to be limited somehow (I guess some kernel=
 mechanism to prevent going wild). The context switches=2C even though they=
're cheap=2C also account for some 8-10% of CPU.<br>I've checked with some =
more knowledgeable people than me and they said in a heavy loaded server I =
should expect something around 30K but I'm around 1M and that's with the ma=
chine just sitting idle.<br>Does anyone know if there is an actual bug=2C a=
nd the appropriate patch to fix it=3B or whether it is considered OK this b=
ehavior? <br><br>Fabian<br><br>Running vmstat I see:<br>Without bridges:<br=
>&nbsp=3B 1&nbsp=3B 0 187312&nbsp=3B 58088&nbsp=3B 32144 338636&nbsp=3B&nbs=
p=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 0&=
nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B 189&nbsp=3B 997 83&nbsp=3B 1 17&n=
bsp=3B 0<br>&nbsp=3B1&nbsp=3B 0 187312&nbsp=3B 57948&nbsp=3B 32144 338636&n=
bsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B&=
nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B 140&nbsp=3B 576 25&nbsp=
=3B 1 74&nbsp=3B 0<br>&nbsp=3B1&nbsp=3B 0 187312&nbsp=3B 58088&nbsp=3B 3214=
4 338636&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B 168&nbsp=3B=
 777 83&nbsp=3B 1 17&nbsp=3B 0<br>&nbsp=3B1&nbsp=3B 0 187312&nbsp=3B 58016&=
nbsp=3B 32144 338636&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B 0&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B 1=
54&nbsp=3B 655 26&nbsp=3B 1 73&nbsp=3B 0<br>&nbsp=3B1&nbsp=3B 0 187312&nbsp=
=3B 57960&nbsp=3B 32144 338636&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nb=
sp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 0=
&nbsp=3B 137&nbsp=3B 500 82&nbsp=3B 1 17&nbsp=3B 0<br>&nbsp=3B1&nbsp=3B 0 1=
87312&nbsp=3B 58088&nbsp=3B 32144 338636&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&=
nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B 0&nbsp=3B 154&nbsp=3B 611 25&nbsp=3B 1 74&nbsp=3B 0<br>&nbsp=3B1&n=
bsp=3B 0 187312&nbsp=3B 57960&nbsp=3B 32144 338636&nbsp=3B&nbsp=3B&nbsp=3B =
0&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B 0&nbsp=3B 135&nbsp=3B 525 83&nbsp=3B 1 17&nbsp=3B 0<br>=
<br>With 4 bridges idle (no traffic on the interfaces)<br>&nbsp=3B1&nbsp=3B=
 0 187312&nbsp=3B 50864&nbsp=3B 32276 338632&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=
=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B 0&nbsp=3B 139 134920 81&nbsp=3B 4 15&nbsp=3B 0<br>&nbsp=3B1&nb=
sp=3B 0 187312&nbsp=3B 51012&nbsp=3B 32276 338632&nbsp=3B&nbsp=3B&nbsp=3B 0=
&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B 0&nbsp=3B 178 145827 24&nbsp=3B 3 72&nbsp=3B 0<br>&nbsp=
=3B1&nbsp=3B 0 187312&nbsp=3B 50880&nbsp=3B 32276 338632&nbsp=3B&nbsp=3B&nb=
sp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B=
&nbsp=3B&nbsp=3B 36&nbsp=3B 180 152482 82&nbsp=3B 3 16&nbsp=3B 0<br>&nbsp=
=3B1&nbsp=3B 0 187312&nbsp=3B 50808&nbsp=3B 32276 338636&nbsp=3B&nbsp=3B&nb=
sp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B 145 126225 25&nbsp=3B 2 72&nbsp=3B 0<br>=
&nbsp=3B1&nbsp=3B 0 187312&nbsp=3B 50888&nbsp=3B 32284 338628&nbsp=3B&nbsp=
=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 0&n=
bsp=3B&nbsp=3B&nbsp=3B 56&nbsp=3B 162 136169 82&nbsp=3B 2 16&nbsp=3B 0<br>&=
nbsp=3B1&nbsp=3B 0 187312&nbsp=3B 50820&nbsp=3B 32284 338636&nbsp=3B&nbsp=
=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 0&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B 207 112448 26&nbsp=3B 3 71&nbsp=3B=
 0<br>&nbsp=3B1&nbsp=3B 0 187312&nbsp=3B 50740&nbsp=3B 32284 338636&nbsp=3B=
&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B 0&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B 148 163085 82&nbsp=3B 4 15&=
nbsp=3B 0<br><br>The precedent metrics are from my desktop machine=2C on th=
e actual host where I have more bridges.<br>&nbsp=3B0&nbsp=3B 0&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B 0 679748&nbsp=3B 34448 2404840&nbsp=3B&nbsp=3B=
&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B 67 928669&nbsp=3B 3 10 86&nbs=
p=3B 0<br>&nbsp=3B0&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 0 679=
748&nbsp=3B 34448 2404840&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B=
 0&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=
=3B&nbsp=3B 89 884379&nbsp=3B 2&nbsp=3B 9 90&nbsp=3B 0<br>&nbsp=3B0&nbsp=3B=
 0&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 0 679748&nbsp=3B 34448 2404840&n=
bsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B&=
nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B 66 924828&nbsp=
=3B 2 10 88&nbsp=3B 0<br>&nbsp=3B0&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B 0 679748&nbsp=3B 34456 2404840&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=
=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B 4&nbsp=3B&nbsp=3B 67 906076&nbsp=3B 5&nbsp=3B 8 87&nbsp=3B 0<b=
r>&nbsp=3B0&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 0 679748&nbsp=
=3B 34456 2404840&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbs=
p=3B 67 920194&nbsp=3B 1&nbsp=3B 9 91&nbsp=3B 0<br>&nbsp=3B0&nbsp=3B 0&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 0 679748&nbsp=3B 34456 2404840&nbsp=3B&=
nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
 0&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B 89 905816&nbsp=3B 1&nb=
sp=3B 11 91&nbsp=3B 0<br>&nbsp=3B0&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B 0 679748&nbsp=3B 34464 2404840&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=
=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 0&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B 0&nbsp=3B&nbsp=3B 87 868858&nbsp=3B 3&nbsp=3B 10 91&nbsp=3B 0<=
br><br></div><br /><hr /> <a href=3D'' target=3D'_new'></a></body>
</html>=

--_69c80af7-1ec4-429d-b2c0-c904e57c9078_--
