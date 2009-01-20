MIME-Version: 1.0
Sender: l.mierzwa@gmail.com
Date: Tue, 20 Jan 2009 01:30:12 +0100
Message-ID: <5d777c0a0901191630t63f56ff6md9268b0265909d5e@mail.gmail.com>
From: =?ISO-8859-2?Q?=A3ukasz_Mierzwa?= <prymitive@gmail.com>
Content-Type: multipart/alternative; boundary=001636c5b11777dbf40460df248c
Subject: [Bridge] how to get a list of ip adresses
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--001636c5b11777dbf40460df248c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I'm running kvm virtual machines with bridged networking with libvirtd,
virtual guests are getting ip addresses from dhcp, listing interface
information on kvm host gives me only bridge ip, there is no information
about guests ip assigned by dhcpd to tap interfaces that are added to the
bridge, is there any way to get this information from kvm host system where
the bridge is created? I couldn't find any usable information on this
subject, right now I need to check dhcp leases or login over vnc. Thanks for
any help.

Lucas

--001636c5b11777dbf40460df248c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I&#39;m running kvm virtual machines with bridged networking wit=
h libvirtd, virtual guests are getting ip addresses from dhcp, listing inte=
rface information on kvm host gives me only bridge ip, there is no informat=
ion about guests ip assigned by dhcpd to tap interfaces that are added to t=
he bridge, is there any way to get this information from kvm host system wh=
ere the bridge is created? I couldn&#39;t find any usable information on th=
is subject, right now I need to check dhcp leases or login over vnc. Thanks=
 for any help.<br>
<br>Lucas<br>

--001636c5b11777dbf40460df248c--
