Message-ID: <001901c41415$f8cf2410$f9cd00d5@kastrup>
From: =?iso-8859-1?Q?Ferm=EDn_Gal=E1n?= <fgalan@teleline.es>
Date: Sat, 27 Mar 2004 17:10:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] Limitation in virtual bridge number
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: shemminger@osdl.org
Cc: bridge@osdl.org

Hello,

I would like to know wether the number of
virtual bridges that can be created (with
'brctl addbr') is limited to a given number.

My question is due to certain tests that I have
performed, the number of virtual bridges cann't be
greater than 32. Triying to add the 33rd bridge
with 'brctl addbr' works, but causes the removal
of the oldest one (the first in the 'brctl show' list):
the number of existing virtual bridges is never
more than 32.

As reference, I have performed these tests in
a Linux 2.4.21 kernel, with bridge support compiled
as module (I can give you more information, if you
need it).

Where resides the limitation? In the virtual bridge
kernel support? In the brctl tool? In the way of
compiling? Maybe is a bug?

I would like to know how can I create more
than 32 virtual bridges (if possible).

Thank you very much for your attention!

-------
Ferm=EDn

