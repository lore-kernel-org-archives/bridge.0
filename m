Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=j8z4v8YxtWANrTWb6RFPyfnlW/ootQzYbnhWcATbHWQ=;
 b=AjMTYWO0eXv50h4Efspnrs7DrZdGLyTZb5SWWsRCQUMcCXc1oNqULW6PhRKMLgap58
 B4Krs3qCdiKdxIBQwTlcfDKIX9Hcb/6cnL2UJqNXK2S0+3a1WTdaeEGnylXLthn65qo/
 lah1W+eNY1Leu9LzmbypCiIaZGNz0wy5QR6f6SR/g306mIXdHgIQLbNuVHOKNBFe66Sz
 SrZdOLdgZ91VgLzbtP147JkR4lv0B1cburt4PRocOahUCRM6l9TIherZOKfA3v+z0Rqf
 iyUvAAosQnmzynDKWwVA6QY+xt+DNMQUQb6Tg26+frCQSkIhjFkeafwyQkd3km1GsRhC
 mpxA==
Date: Mon, 14 Mar 2022 19:55:56 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220314175556.7mjr4tui4vb4i5qn@skbuf>
References: <20220314095231.3486931-1-tobias@waldekranz.com>
 <20220314095231.3486931-10-tobias@waldekranz.com>
 <20220314165649.vtsd3xqv7htut55d@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314165649.vtsd3xqv7htut55d@skbuf>
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
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Petr Machata <petrm@nvidia.com>, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Matt Johnston <matt@codeconstruct.com.au>, davem@davemloft.net, linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 06:56:49PM +0200, Vladimir Oltean wrote:
> > diff --git a/net/dsa/port.c b/net/dsa/port.c
> > index 58291df14cdb..1a17a0efa2fa 100644
> > --- a/net/dsa/port.c
> > +++ b/net/dsa/port.c
> > @@ -240,6 +240,10 @@ static int dsa_port_switchdev_sync_attrs(struct dsa_port *dp,
> >  	if (err && err != -EOPNOTSUPP)
> >  		return err;
> >  
> > +	err = dsa_port_mst_enable(dp, br_mst_enabled(br), extack);
> > +	if (err && err != -EOPNOTSUPP)
> > +		return err;
> 
> Sadly this will break down because we don't have unwinding on error in
> place (sorry). We'd end up with an unoffloaded bridge port with
> partially synced bridge port attributes. Could you please add a patch
> previous to this one that handles this, and unoffloads those on error?

Actually I would rather rename the entire dsa_port_mst_enable() function
to dsa_port_mst_validate() and move it to the beginning of dsa_port_bridge_join().
This simplifies the unwinding that needs to take place quite a bit.
