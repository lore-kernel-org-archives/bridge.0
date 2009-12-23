MIME-Version: 1.0
In-Reply-To: <2e59e6970912230603r9a875e6rb5bc0da53e7d6ba6@mail.gmail.com>
Message-ID: <00163600ce448e8674047b65d7bf@google.com>
Date: Wed, 23 Dec 2009 14:07:25 +0000
From: jhautbois@gmail.com
Content-Type: multipart/alternative; boundary=00163600ce448e8654047b65d7bc
Subject: [Bridge] =?iso-8859-1?q?Re=A0=3ARe=3A__ebtables=2C_PF=5FPACKET_an?=
	=?iso-8859-1?q?d_other_stuff?=
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "richardvoigt@gmail.com" <richardvoigt@gmail.com>, Jean-Michel Hautbois <jhautbois@gmail.com>
Cc: bridge@lists.linux-foundation.org

--00163600ce448e8654047b65d7bc
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes

> Send those packets to the ULOG target when dropping them.



>  From the ebtables manpage:



> ulog



> The ulog watcher passes the packet to a userspace logging daemon using

> netlink multicast sockets. This differs from the log watcher in the

> sense that the complete packet is sent to userspace instead of a

> descriptive text and that netlink multicast sockets are used instead

> of the syslog. This watcher enables parsing of packets with userspace

> programs

> (snip)

Mmh, ok, but from the userspace point of view, how can I get them ? A  
SOCK_RAW ?

JM

--00163600ce448e8654047b65d7bc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

&gt; Send those packets to the ULOG target when dropping them.<br />&gt; <b=
r />&gt; <br />&gt; <br />&gt; From the ebtables manpage:<br />&gt; <br />&=
gt; <br />&gt; <br />&gt; ulog<br />&gt; <br />&gt; <br />&gt; <br />&gt; T=
he ulog watcher passes the packet to a userspace logging daemon using<br />=
&gt; <br />&gt; netlink multicast sockets. This differs from the log watche=
r in the<br />&gt; <br />&gt; sense that the complete packet is sent to use=
rspace instead of a<br />&gt; <br />&gt; descriptive text and that netlink =
multicast sockets are used instead<br />&gt; <br />&gt; of the syslog. This=
 watcher enables parsing of packets with userspace<br />&gt; <br />&gt; pro=
grams<br />&gt; <br />&gt; (snip)<br /><br />Mmh, ok, but from the userspac=
e point of view, how can I get them ? A SOCK_RAW ?<br /><br />JM
--00163600ce448e8654047b65d7bc--
