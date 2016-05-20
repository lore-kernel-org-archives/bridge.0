Return-Path: <chenchanglong2016@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to;
	bh=iqX0L/kZJGo3xQKFWBL/lEu6g7LxCkzEO5ITBG16UKI=;
	b=dy6n3zVnphZXZ1DssUKuyAO/f9au/ITbns5lxRlvclZGzJhThziP4HW8Or69xXiWXF
	Kkv4KuDU3r4pFmSXs0wko9y7xhYzxYa2qvWFS1VWRcpshgJvlV5TPFY9f65VoP2+723J
	mEFu6Rck5PVDLWqfdMd8dHZxPLqgBeDBUk34GUpv64WpnMuk3GroZ4xxc/FtSW3GbwEd
	8wvGbkk1eOymLNtdRcY4DZjJFY8X7G6sTTRgaDQ9tChZTZmTlyXm0N7coFpzmiAJ1iyz
	qnjn/dhtHKUyHHc4AMoiLENa7auXv90pWbR8XbaNZsrSz9zOg6RMqU2cfsJnsSxhFhz4
	qQtA==
MIME-Version: 1.0
Date: Fri, 20 May 2016 13:56:13 +0800
Message-ID: <CAAoNYVNFqmandFB5MY5L2+zw=sAv47=0OBRrgU0whkJy_f6rZw@mail.gmail.com>
From: aaron chen <chenchanglong2016@gmail.com>
Content-Type: multipart/alternative; boundary=001a1144d02894183705333fbfbe
Subject: [Bridge] RSTP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--001a1144d02894183705333fbfbe
Content-Type: text/plain; charset=UTF-8

Great bridge friends:

I port  linux-4.1.14 to my arm board, and the STP works fine in the loops
of the boards. But I want a faster performance, so I need to use RSTP. I
visit the www.linuxfoundation.org and it said "work is being done to
integrate RSTP support in a future 2.6 release".

so, I want to know if the linux-4.1.14 supports RSTP ? How can I  use it ?
 if not, could you give me some advices to port the RSTP to my board?

Best Wishes

Aaron Chen
from China
2016-05-20

--001a1144d02894183705333fbfbe
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Great bridge friends:<div><br></div><div>I port =C2=A0linu=
x-4.1.14 to my arm board, and the STP works fine in the loops of the boards=
. But I want a faster performance, so I need to use RSTP. I visit the <a hr=
ef=3D"http://www.linuxfoundation.org">www.linuxfoundation.org</a> and it sa=
id &quot;<span style=3D"color:rgb(77,77,77);font-family:Tahoma,Verdana,Aria=
l,Helvetica,&#39;Bitstream Vera Sans&#39;,sans-serif;font-size:12.96px;line=
-height:19.8288px">work is being done to integrate RSTP support in a future=
 2.6 release&quot;.</span></div><div><span style=3D"color:rgb(77,77,77);fon=
t-family:Tahoma,Verdana,Arial,Helvetica,&#39;Bitstream Vera Sans&#39;,sans-=
serif;font-size:12.96px;line-height:19.8288px"><br></span></div><div><span =
style=3D"color:rgb(77,77,77);font-family:Tahoma,Verdana,Arial,Helvetica,&#3=
9;Bitstream Vera Sans&#39;,sans-serif;font-size:12.96px;line-height:19.8288=
px">so, I want to know if the linux-4.1.14 supports RSTP ? How can I =C2=A0=
use it ? =C2=A0if not, could you give me some advices to port the RSTP to m=
y board?</span></div><div><span style=3D"color:rgb(77,77,77);font-family:Ta=
homa,Verdana,Arial,Helvetica,&#39;Bitstream Vera Sans&#39;,sans-serif;font-=
size:12.96px;line-height:19.8288px"><br></span></div><div><font color=3D"#4=
d4d4d" face=3D"Tahoma, Verdana, Arial, Helvetica, Bitstream Vera Sans, sans=
-serif"><span style=3D"font-size:12.96px;line-height:19.8288px">Best Wishes=
</span></font></div><div><font color=3D"#4d4d4d" face=3D"Tahoma, Verdana, A=
rial, Helvetica, Bitstream Vera Sans, sans-serif"><span style=3D"font-size:=
12.96px;line-height:19.8288px"><br></span></font></div><div><span style=3D"=
color:rgb(77,77,77);font-family:Tahoma,Verdana,Arial,Helvetica,&#39;Bitstre=
am Vera Sans&#39;,sans-serif;font-size:12.96px;line-height:19.8288px">Aaron=
 Chen</span></div><div><span style=3D"color:rgb(77,77,77);font-family:Tahom=
a,Verdana,Arial,Helvetica,&#39;Bitstream Vera Sans&#39;,sans-serif;font-siz=
e:12.96px;line-height:19.8288px">from China=C2=A0</span></div><div><span st=
yle=3D"color:rgb(77,77,77);font-family:Tahoma,Verdana,Arial,Helvetica,&#39;=
Bitstream Vera Sans&#39;,sans-serif;font-size:12.96px;line-height:19.8288px=
">2016-05-20</span></div></div>

--001a1144d02894183705333fbfbe--
