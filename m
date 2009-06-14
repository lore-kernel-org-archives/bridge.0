MIME-Version: 1.0
Date: Sun, 14 Jun 2009 16:28:36 +0800
Message-ID: <6d6e77f50906140128t65853593y61bf65c200970864@mail.gmail.com>
From: eko suwarsono <ekoswr76@gmail.com>
Content-Type: multipart/alternative; boundary=0015175cd534570256046c4aba9e
Subject: [Bridge] bridge module insertion
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--0015175cd534570256046c4aba9e
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

dear all
I'm newbie on this. but i need the advise for this problem. sorry if this
already in archive

I had embedded system from vendor using ubuntu 7.  with kernel 2.6.20.4 the
system is on CF card
i need to have the bridge module on that systems, the problem there is no
compiler,etc. very minimum system
so what i did is install ubuntu on another PC and using exactly the same
kernel, gcc version etc to get the kernel with bridge module and then
copying all /boot folders and /lib/modules onto my embedded system

the bridge module get error: insmod: error inserting bridge.ko : unknown
symbol

at dmesg

bridge: Unknown symbol br_handle_frame_hook



is there any way to solve this problem, without rebuilding all OS on CF card

--0015175cd534570256046c4aba9e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

dear all<br>I&#39;m newbie on this. but i need the advise for this problem.=
 sorry if this already in archive<br>=A0<br>I had embedded system from vend=
or using ubuntu 7.=A0 with kernel 2.6.20.4 the system is on CF card<br>i ne=
ed to have the bridge module on that systems, the problem there is no compi=
ler,etc. very minimum system<br>

so what i did is install ubuntu on another PC and using exactly the
same kernel, gcc version etc to get the kernel with bridge module and
then copying all /boot folders and /lib/modules onto my embedded system<br>=
=A0<br>the bridge module get error: insmod: error inserting bridge.ko : unk=
nown symbol <br><br>at dmesg<br><pre>bridge: Unknown symbol br_handle_frame=
_hook<br>
</pre><br>
=A0<br>is there any way to solve this problem, without rebuilding all OS on=
 CF card=20

--0015175cd534570256046c4aba9e--
