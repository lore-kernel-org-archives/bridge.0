Message-ID: <fed120860805080927y427788f3m90db4bd20f4bfa11@mail.gmail.com>
Date: Thu, 8 May 2008 21:57:29 +0530
From: "Srinivas M.A." <srinivas.aji@gmail.com>
In-Reply-To: <48218D4C.10108@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <48218D4C.10108@free.fr>
Subject: Re: [Bridge] RSTP user mode implementation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Benoit PAPILLAULT <benoit.papillault@free.fr>
Cc: Bridge@lists.linux-foundation.org

Hi,

Independent of my plug for the newer version, could you send more
information from your segfault, like a stack trace? I could help with
debugging the crash.

Kernels later than 2.6.21 should be good enough.

On Wed, May 7, 2008 at 4:36 PM, Benoit PAPILLAULT
<benoit.papillault@free.fr> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Hello,
>
> I'm new to STP and RSTP. I'm however trying to implement a new bridge
> protocol. I'm trying the RSTP code available at :
>
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/shemminger/rstp.git
>
> It compiles fine. However, it segfaults using a 2.6.22 kernel from
> Ubuntu. Since the documentation is pretty scare, are there requirements
> on the kernel version or kernel features?
>
> Moreover, it seems the last commit was done in May 2007. Are new
> developments taking place at some other location? Or is the project
> dead? I really like the idea of implementing bridging at user level, it
> should allow me to try a new bridge protocol pretty easily.
>
> Regards,
> Benoit
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.6 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
>
> iD8DBQFIIY1MOR6EySwP7oIRAsULAKDuR3667Gsmc9hTulKrlXZeuXYb5ACgyGnA
> R8cRMbR98E06PK0kEn6Nlms=
> =x0MY
> -----END PGP SIGNATURE-----
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
