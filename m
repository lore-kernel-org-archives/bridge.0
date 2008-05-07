Message-ID: <48218D4C.10108@free.fr>
Date: Wed, 07 May 2008 13:06:52 +0200
From: Benoit PAPILLAULT <benoit.papillault@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] RSTP user mode implementation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Bridge@lists.linux-foundation.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I'm new to STP and RSTP. I'm however trying to implement a new bridge
protocol. I'm trying the RSTP code available at :

git clone git://git.kernel.org/pub/scm/linux/kernel/git/shemminger/rstp.git

It compiles fine. However, it segfaults using a 2.6.22 kernel from
Ubuntu. Since the documentation is pretty scare, are there requirements
on the kernel version or kernel features?

Moreover, it seems the last commit was done in May 2007. Are new
developments taking place at some other location? Or is the project
dead? I really like the idea of implementing bridging at user level, it
should allow me to try a new bridge protocol pretty easily.

Regards,
Benoit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIIY1MOR6EySwP7oIRAsULAKDuR3667Gsmc9hTulKrlXZeuXYb5ACgyGnA
R8cRMbR98E06PK0kEn6Nlms=
=x0MY
-----END PGP SIGNATURE-----
