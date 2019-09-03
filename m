Return-Path: <leonardo@linux.ibm.com>
Message-ID: <a2f0d0b08a73d86e8a1f67c4eeea3be11614aada.camel@linux.ibm.com>
From: Leonardo Bras <leonardo@linux.ibm.com>
Date: Tue, 03 Sep 2019 13:56:11 -0300
In-Reply-To: <20190903164948.kuvtpy7viqhcmp77@salvia>
References: <20190830181354.26279-1-leonardo@linux.ibm.com>
	<20190830181354.26279-2-leonardo@linux.ibm.com>
	<20190830205802.GS20113@breakpoint.cc>
	<99e3ef9c5ead1c95df697d49ab9cc83a95b0ac7c.camel@linux.ibm.com>
	<20190903164948.kuvtpy7viqhcmp77@salvia>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-sCCUtoKpTC9VzNlcdhEG"
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v4 1/2] netfilter: Terminate rule eval if
 protocol=IPv6 and ipv6 module is disabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, FlorianWestphal <fw@strlen.de>, linux-kernel@vger.kernel.org, Jozsef Kadlecsik <kadlec@netfilter.org>, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>


--=-sCCUtoKpTC9VzNlcdhEG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-09-03 at 18:49 +0200, Pablo Neira Ayuso wrote:
> On Tue, Sep 03, 2019 at 01:46:50PM -0300, Leonardo Bras wrote:
> > On Fri, 2019-08-30 at 22:58 +0200, Florian Westphal wrote:
> > Hello Pablo,
> >=20
> > Any trouble with this patch?=20
> > I could see the other* one got applied, but not this one.
> > *(The other did not get acked, so i released it alone as v5)
> >=20
> > Is there any fix I need to do in this one?
>=20
> Hm, I see, so this one:
>=20
> https://patchwork.ozlabs.org/patch/1156100/
>=20
> is not enough?

By what I could understand of Florian e-mail, we would need both:

>> So, given I don't want to plaster ipv6_mod_enabled() everywhere, I
>> would suggest this course of action:
>>
>> 1. add a patch to BREAK in nft_fib_netdev.c for !ipv6_mod_enabled()
>> 2. change net/bridge/br_netfilter_hooks.c, br_nf_pre_routing() to
>>    make sure ipv6_mod_enabled() is true before doing the ipv6 stack
>>    "emulation".

Is that ok?

>=20
> I was expecting we could find a way to handle this from br_netfilter
> alone itself.
>=20
> Thanks.
Thank you!

--=-sCCUtoKpTC9VzNlcdhEG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl1umysACgkQlQYWtz9S
ttSPAA/9GCXjQ8Us2+uyMm9QRIsc5twobC8qN1ce3/b24ZxQ9u5+agoyU3d4mMJD
CXH4Ws1wl7wzkByiZiDaJxzKj9yM4RjqyXHhquOG1qqbYq6f7077irnslJTYySEs
yIXs/MQMEB2mF9ZRXRdwSvNJSyyR52EwZbMSY7xHKW3Z/l25gNbjgJLMy3Dbu7jr
k0/36+iPPXSVp+08LMtxuysM3Rwji4fRftdPuEq7ardu+7GQOaim6oSZ0s9pzw5O
jEsSjEjmP+kVc6HCFlyA0eDD9zInjmjLRsHizbSISx+My9obHy1OnburEd846z/y
UNaQd269+0eFmRXZuQun+Myrs5GgUBt9DvGLcEKm7AXN3bgaHv2+w/k3GDr/OWCp
7fsDHLkJdPuPc4mUFG3u5KhKWRHMkTURI14OuZGC9NO83lIi412imaZLSEkWVpL2
MX9DJhbE/daNz3DhAMq3mEf6cyMGARUWU+oeJY80pjbrrsQKPEsV5KjxJLRNRZxz
UBp+C5I3ASMS2gzjswwHUMJX4iV5zJDmEiaID1ftgcZlPeuoxBgVGTeF2Rp9gcts
XHVl6hort3xwRx7hf1N83wmakhyV/wYEFVGmorzJu2Y4+5OJkk/+CoNv9pQwljvJ
tL2K8VjDhxp6dkQK7dGmflb95qMfeQN1kXimC84IcKA3wFc1SCk=
=IFln
-----END PGP SIGNATURE-----

--=-sCCUtoKpTC9VzNlcdhEG--

