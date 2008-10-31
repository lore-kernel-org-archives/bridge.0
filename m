Message-ID: <682aabc20810311246v27802eb6o42dda5f9fd1ca429@mail.gmail.com>
Date: Fri, 31 Oct 2008 15:46:47 -0400
From: "Bow-Nan Cheng" <bownan@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_14996_23870312.1225482407687"
Subject: [Bridge] Bridging PPPoE Sessions together
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

------=_Part_14996_23870312.1225482407687
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I have a PPPoE server running on a linux box that accepts multiple PPPoE
sessions from clients. I'd like to bridge each of the sessions together so
that it looks like just one interface. Below is a diagram:

     br0
      |
-------------------------------
|           |          |            |
ppp0  ppp1   eth3  ppp3

I've read that anything can be bridge as long as MTU is the same. Since
PPPoE has ethernet headers, i'm assuming that each of the devices ppp0,
ppp1, ppp3 have those as well. Is bridging them together as simple as:

brctl addbr br0
brctl addif ppp0
brctl addif ppp1
brctl addif eth3
brctl addif ppp3

?
Thanks for any help!

--
Bow-Nan Cheng
http://networks.ecse.rpi.edu/~bownan
Phone: 201.563.3875
AIM: BowNanC

------=_Part_14996_23870312.1225482407687
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I have a PPPoE server running on a linux box that accepts multiple PPPoE sessions from clients. I&#39;d like to bridge each of the sessions together so that it looks like just one interface. Below is a diagram:<br>
<br>&nbsp;&nbsp;&nbsp;&nbsp; br0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>-------------------------------<br>|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>ppp0&nbsp; ppp1&nbsp;&nbsp; eth3&nbsp; ppp3<br><br>I&#39;ve read that anything can be bridge as long as MTU is the same. Since PPPoE has ethernet headers, i&#39;m assuming that each of the devices ppp0, ppp1, ppp3 have those as well. Is bridging them together as simple as:<br>
<br>brctl addbr br0<br>brctl addif ppp0<br>brctl addif ppp1<br>brctl addif eth3<br>brctl addif ppp3<br><br>?<br>Thanks for any help!<br clear="all"><br>--<br>Bow-Nan Cheng<br><a href="http://networks.ecse.rpi.edu/~bownan">http://networks.ecse.rpi.edu/~bownan</a><br>
Phone: 201.563.3875<br>AIM: BowNanC<br>

------=_Part_14996_23870312.1225482407687--
