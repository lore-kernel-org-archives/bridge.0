Return-Path: <schultz.hans@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version:content-transfer-encoding;
 bh=bk6iCziDs7KEQNE/9x22f3LO3qPYLR33HEQGFJDm3+k=;
 b=aq0QkXeh4owaIu+yypuEQ1a2yBDhwHw/SbxYGwXQJugzlJBo5NGN1vgaSKE1s8blTC
 nWlDO0+/q1CV1osEyC1ffUM28jtOwbQo4awy97wV1Vcg9B3+Z8FQxY6d78m2ViRfd0gm
 E8I3MGRy8Kk6+E7kBzN77teBDGcujJaspYOFJhzzMhBWVhdQIXCMu/af+jiYgaOexucX
 Lw0bstn4EUJRy2pUBz1IprvGW42vTqu1n1xdBYTSOY3twHqMnQvAME0a6FQDOKMJ9ZLi
 I2OySGBHpmlmw1hvIYla97mGlfYFL7tDQScnZw/w8+tUqo+8csOR7UozJ4hP/hAarYre
 qi1A==
From: Hans Schultz <schultz.hans@gmail.com>
In-Reply-To: <YhIIJxxXP3JzD60/@shredder>
References: <20220218155148.2329797-1-schultz.hans+netdev@gmail.com>
 <20220218155148.2329797-5-schultz.hans+netdev@gmail.com>
 <20220219100034.lh343dkmc4fbiad3@skbuf> <YhIIJxxXP3JzD60/@shredder>
Date: Mon, 21 Feb 2022 15:05:58 +0100
Message-ID: <86h78sqpq1.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net-next v3 4/5] net: dsa: mv88e6xxx: Add
 support for bridge port locked mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>, Vladimir Oltean <olteanv@gmail.com>
Cc: Petr Machata <petrm@nvidia.com>, Andrew Lunn <andrew@lunn.ch>, Baowen Zheng <baowen.zheng@corigine.com>, Florian Fainelli <f.fainelli@gmail.com>, Amit Cohen <amcohen@nvidia.com>, netdev@vger.kernel.org, Hans Schultz <schultz.hans@gmail.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Po-Hsu Lin <po-hsu.lin@canonical.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Stephen Suryaputra <ssuryaextr@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On s=C3=B6n, feb 20, 2022 at 11:21, Ido Schimmel <idosch@idosch.org> wrote:
> On Sat, Feb 19, 2022 at 12:00:34PM +0200, Vladimir Oltean wrote:
>> On Fri, Feb 18, 2022 at 04:51:47PM +0100, Hans Schultz wrote:
>> > diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6=
xxx/port.c
>> > index ab41619a809b..46b7381899a0 100644
>> > --- a/drivers/net/dsa/mv88e6xxx/port.c
>> > +++ b/drivers/net/dsa/mv88e6xxx/port.c
>> > @@ -1234,6 +1234,39 @@ int mv88e6xxx_port_set_mirror(struct mv88e6xxx_=
chip *chip, int port,
>> >  	return err;
>> >  }
>> >=20=20
>> > +int mv88e6xxx_port_set_lock(struct mv88e6xxx_chip *chip, int port,
>> > +			    bool locked)
>> > +{
>> > +	u16 reg;
>> > +	int err;
>> > +
>> > +	err =3D mv88e6xxx_port_read(chip, port, MV88E6XXX_PORT_CTL0, &reg);
>> > +	if (err)
>> > +		return err;
>> > +
>> > +	reg &=3D ~MV88E6XXX_PORT_CTL0_SA_FILT_MASK;
>> > +	if (locked)
>> > +		reg |=3D MV88E6XXX_PORT_CTL0_SA_FILT_DROP_ON_LOCK;
>> > +
>> > +	err =3D mv88e6xxx_port_write(chip, port, MV88E6XXX_PORT_CTL0, reg);
>> > +	if (err)
>> > +		return err;
>> > +
>> > +	err =3D mv88e6xxx_port_read(chip, port, MV88E6XXX_PORT_ASSOC_VECTOR,=
 &reg);
>> > +	if (err)
>> > +		return err;
>> > +
>> > +	reg &=3D ~MV88E6XXX_PORT_ASSOC_VECTOR_LOCKED_PORT;
>> > +	if (locked)
>> > +		reg |=3D MV88E6XXX_PORT_ASSOC_VECTOR_LOCKED_PORT;
>> > +
>> > +	err =3D mv88e6xxx_port_write(chip, port, MV88E6XXX_PORT_ASSOC_VECTOR=
, reg);
>>=20
>> 	return mv88e6xxx_port_write(...);
>
> Not familiar with mv88e6xxx, but shouldn't there be a rollback of
> previous operations? Specifically mv88e6xxx_port_write()
>

If a register write function fails, I don't think that it would make
sense to try and resolve the situation by additional register write
calls (rollback).

>>=20
>> > +	if (err)
>> > +		return err;
>> > +
>> > +	return 0;
>> > +}
