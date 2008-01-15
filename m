From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Date: Wed, 16 Jan 2008 00:45:19 +0100
Message-ID: <001001c857d0$b06b1140$114133c0$@tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Language: sv
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] Fw: Retain an IP address on a i/f partcipating in a bridge?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Found this list after sending 'bridge@osdl.org'. Not sure which one
to use so I send it here too.

-----Ursprungligt meddelande-----
Fr=E5n: Joakim Tjernlund [mailto:joakim.tjernlund@transmode.se]=20
Skickat: den 16 januari 2008 00:33
Till: 'bridge@osdl.org'
=C4mne: Retain an IP address on a i/f partcipating in a bridge?

Currently one must unset the IP address on an i/f that is included in a
bridge and
move the IP address to the bridge i/f instead if one wants to maintain
connectivity with
the box. This is a problem for us as one loses all routes. The rename of the
i/f=20
is also a problem.

Is there a fundamental reason one cannot keep the IP address on one i/f that
is a member in a bride? I only have two real interfaces in the bridge if
that=20
makes it any easier.
Any pointers where I need to adjust the bride code would be appreciated.

     Jocke


