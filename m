Return-Path: <David.Laight@ACULAB.COM>
From: David Laight <David.Laight@ACULAB.COM>
Date: Fri, 6 Jun 2014 15:56:52 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D17258AEA@AcuExch.aculab.com>
References: <1402047743-3391-1-git-send-email-kenhelias@firemail.de>
In-Reply-To: <1402047743-3391-1-git-send-email-kenhelias@firemail.de>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH] list: Fix order of arguments for
	hlist_add_after(_rcu)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: 'Ken Helias' <kenhelias@firemail.de>, lkml <linux-kernel@vger.kernel.org>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>

From: Behalf Of Ken Helias
> All other add functions for lists have the new item as first argument and=
 the
> position where it is added as second argument. This was changed for no go=
od
> reason in this function and makes using it unnecessary confusing.
>=20
> Also the naming of the arguments in hlist_add_after was confusing. It was
> changed to use the same names as hlist_add_after_rcu.
...
> -static inline void hlist_add_after_rcu(struct hlist_node *prev,
> -				       struct hlist_node *n)
> +static inline void hlist_add_after_rcu(struct hlist_node *n,
> +				       struct hlist_node *prev)

It is rather a shame that the change doesn't generate a compilation
error for old source files.

	David



