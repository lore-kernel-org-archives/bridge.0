Date: Wed, 5 May 2010 08:20:21 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20100505082021.627ab01b@nehalam>
In-Reply-To: <20100505100604.7cd09d04.taeuber@bbaw.de>
References: <20100505100604.7cd09d04.taeuber@bbaw.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] which interface for IP address?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Lars =?ISO-8859-1?B?VOR1YmVy?= <taeuber@bbaw.de>
Cc: bridge@lists.linux-foundation.org

On Wed, 5 May 2010 10:06:04 +0200
Lars T=E4uber <taeuber@bbaw.de> wrote:

> Hi there,
>=20
> why do all the howtos set the ip address to the brigde? Isn't it also pos=
sible to assign the address the real interface?

No. packets get diverted to the bridge before IP processing.

> What's the difference between assigning the address to the bridge and ass=
igning the address to the real interface contained by the bridge?
>=20

You end up with partial connectivity (send but not receive).

--=20
