Date: Thu, 6 May 2010 09:08:34 +0200
From: Lars =?UTF-8?B?VMOkdWJlcg==?= <taeuber@bbaw.de>
Message-Id: <20100506090834.f267a478.taeuber@bbaw.de>
In-Reply-To: <20100505082021.627ab01b@nehalam>
References: <20100505100604.7cd09d04.taeuber@bbaw.de>
	<20100505082021.627ab01b@nehalam>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: bridge@lists.linux-foundation.org

Stephen Hemminger <shemminger@linux-foundation.org> schrieb:
> On Wed, 5 May 2010 10:06:04 +0200
> Lars T=C3=A4uber <taeuber@bbaw.de> wrote:
>=20
> > Hi there,
> >=20
> > why do all the howtos set the ip address to the brigde? Isn't it also=
 possible to assign the address the real interface?
>=20
> No. packets get diverted to the bridge before IP processing.

Oh, I see. That's a reason to do it like it is written everywhere.

=20
> > What's the difference between assigning the address to the bridge and=
 assigning the address to the real interface contained by the bridge?
> >=20
>=20
> You end up with partial connectivity (send but not receive).


Thanks
Lars
