Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=F5mU9o7savlVkOpAVXAc7vZgunxy8jXIc2Wup8XxmsY=;
 b=U9r3p6udDqYlZ1aopd62hIGt17gWQvQg7QbrFEqTQOh59FTbqt6d+jnOaxtuOemxUx
 fc8Cm//gfPrMpb46jCfiDzcT2SRuCSHU4LZvHM+j4uGUzaPmhhsaFt3Mra/xnGnwt3z1
 NvVVn/WRXQJVn3RMkkWAQxgRotPoF/Cf/qFIxY5bKHkOBrBM7//tpkLQf7zt1KFfgzD+
 YNEi7mazSo0xLGI7QHGT/qPi++c6x9OOylHKgsHWcp8raYtetaDbdH/UxwcuqaGuJmzX
 pX4Nj7n69fCKkgPH++8LHtka06ngmG4Ta9Hdb2RTKiknFDUEjkh7aClHpBD7jW+pFoBk
 zMpw==
From: Tobias Waldekranz <tobias@waldekranz.com>
In-Reply-To: <20220314175556.7mjr4tui4vb4i5qn@skbuf>
References: <20220314095231.3486931-1-tobias@waldekranz.com>
 <20220314095231.3486931-10-tobias@waldekranz.com>
 <20220314165649.vtsd3xqv7htut55d@skbuf>
 <20220314175556.7mjr4tui4vb4i5qn@skbuf>
Date: Mon, 14 Mar 2022 21:01:12 +0100
Message-ID: <87mthsl2wn.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH v3 net-next 09/14] net: dsa: Validate hardware
 support for MST
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Petr Machata <petrm@nvidia.com>, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Matt Johnston <matt@codeconstruct.com.au>, davem@davemloft.net, linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 19:55, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Mon, Mar 14, 2022 at 06:56:49PM +0200, Vladimir Oltean wrote:
>> > diff --git a/net/dsa/port.c b/net/dsa/port.c
>> > index 58291df14cdb..1a17a0efa2fa 100644
>> > --- a/net/dsa/port.c
>> > +++ b/net/dsa/port.c
>> > @@ -240,6 +240,10 @@ static int dsa_port_switchdev_sync_attrs(struct dsa_port *dp,
>> >  	if (err && err != -EOPNOTSUPP)
>> >  		return err;
>> >  
>> > +	err = dsa_port_mst_enable(dp, br_mst_enabled(br), extack);
>> > +	if (err && err != -EOPNOTSUPP)
>> > +		return err;
>> 
>> Sadly this will break down because we don't have unwinding on error in
>> place (sorry). We'd end up with an unoffloaded bridge port with
>> partially synced bridge port attributes. Could you please add a patch
>> previous to this one that handles this, and unoffloads those on error?
>
> Actually I would rather rename the entire dsa_port_mst_enable() function
> to dsa_port_mst_validate() and move it to the beginning of dsa_port_bridge_join().
> This simplifies the unwinding that needs to take place quite a bit.

Well you still need to unwind vlan filtering if setting the ageing time
fails, which is the most complicated one, right? Still, I agree that
_validate is a better name, and then _bridge_join seems like a more
reasonable placement. Should the unwinding patch still be part of this
series then?

While we're here, I actually made this a hard error in both scenarios
(but forgot to update the log - will do that in v4, depending on what we
decide here). There's a dilemma:

- When reacting to the attribute event, i.e. changing the mode on a
  member we're apart of, we _can't_ return -EOPNOTSUPP as it will be
  ignored, which is why dsa_port_mst_validate (nee _enable) returns
  -EINVAL.

- When joining a bridge, we _must_ return -EOPNOTSUPP to trigger the
  software fallback.

Having something like this in dsa_port_bridge_join...

err = dsa_port_mst_validate(dp);
if (err == -EINVAL)
	return -EOPNOTSUPP;
else if (err)
	return err;

...works I suppose, but feels somewhat awkwark. Any better ideas?

