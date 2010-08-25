Message-ID: <4C752DD9.7040302@tiolive.com>
Date: Wed, 25 Aug 2010 16:51:05 +0200
From: =?ISO-8859-1?Q?Fran=E7ois_Schmidts?= <francois@tiolive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] Number of addresses limitation
Reply-To: francois@tiolive.com
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

  Hi,

I'm using bridge-utils to add a bunch of tap interfaces to my computer=20
so I can run different qemu vm at the same time without using nat to=20
give them network access. It works fine.

But at the same time I would like to add a lot of IPv6s addresses to the=20
bridge interface (br0). I find myself limitated to more or less 56=20
addresses. If I add one more, one of the addresses already existing just=20
disappear from the br0 interface.

Is there something I could do to remove or extent this limitation ?

Best regards,
Fran=E7ois Schmidts.
