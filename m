Date: Wed, 30 Mar 2011 11:25:20 -0500
From: Igor Serebryany <igor47@moomers.org>
Message-ID: <20110330162520.GN23639@moomers.org>
References: <loom.20110328T194703-472@post.gmane.org>
	<m3y63whdih.fsf@ursa.amorsen.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <m3y63whdih.fsf@ursa.amorsen.dk>
Subject: Re: [Bridge] 802.1q tagging broken when used with bridging in 2.6.38
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

On Wed, Mar 30, 2011 at 04:46:46PM +0200, Benny Amorsen wrote:
> > now, i want to assign eth0 to a bridge
> >
> > brctl addbr xenbr0
> > ifconfig xenbr0 up
> > brctl addif xenbr0 eth0
>=20
> I may be misunderstanding your topology, but I would have expected that
> you would want to brctl addif xenbr0 eth0.234? It is unusual to bridge
> an interface and expect tagged packets to traverse the bridge (typically
> done in q-in-q setups).

I have some virtual machines which just use the native vlan, and their
virtual adapters go on xenbr0 along with eth0. I also have some virtual
machines which go on special vlans. For those, I create additional
bridges and put the virtual nics on the additional bridges along with
the tagged interfaces.

--Igor
