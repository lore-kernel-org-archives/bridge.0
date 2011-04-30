MIME-Version: 1.0
Sender: aenertia@aenertia.net
In-Reply-To: <4DBAE840.2060705@tektronix.com>
References: <4DBAE840.2060705@tektronix.com>
From: Joel Wiramu Pauling <joel@aenertia.net>
Date: Sat, 30 Apr 2011 15:26:24 +1200
Message-ID: <BANLkTinhVdrMEgU8L9qvYsw1iB1zN52KgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] no wireless interfaces?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joe Harvell <joe.harvell@tektronix.com>
Cc: Bridge@lists.linux-foundation.org

Because 802.11a/b/g/n does odd things with mac headers which make
bridging them sometimes not work as expected.

On 30 April 2011 04:33, Joe Harvell <joe.harvell@tektronix.com> wrote:
> I tried to bridge a wireless interface to a wired Ethernet interface,
> and it failed with "Operation not supported."
>
> Looking at the kernel code, it seems like this is intentional. =C2=A0I
> noticed the following in br_add_if:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* No bridging devices that dislike that (e.g.=
 wireless) */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dev->priv_flags & IFF_DONT_BRIDGE)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EOPNOTSUPP=
;
>
> I'm curious to know why this is not supported.
>
> ---
> Joe
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
