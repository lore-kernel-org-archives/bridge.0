Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=se+rvnHLTMwCDJuZUUaKeJfsDcgnDN9KN2DXN5nL3LI=;
 b=FqRhB8kJ7DAPHXMUR4z2dXdwLCMDBNZYZTQxZ8mZHljQbWDn62iBugk7EMcvIncaBu
 XkX1ohnXLsVuz41HeOEZqTzvefSfZ6GVV2ojTj8B+yE9UVomafyGCXu43qCy9UYqUZZz
 N1/1P29Zqpvkc75cVYt3YuF6wxMRhXbUEuucSLq/T5UGw3q40fX+pREKSbBezaoBeGV8
 ybfL5HMUxmYPlOCp3VHcKTZ29Krhsn4fVpaBvhm2+AFt1Z/Kx+973+5/N2BkVzFU/6nV
 rz2MtO8QBO2Szkw1W6xfAgaQek3XkEXq1Gn3QpmBBhcZzMyvoPy5WCjExWDmsDOu5rET
 IDBQ==
Date: Wed, 16 Mar 2022 15:03:49 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220316130349.kmjonrhsx7upj55h@skbuf>
References: <20220315002543.190587-1-tobias@waldekranz.com>
 <20220315002543.190587-11-tobias@waldekranz.com>
 <20220315171108.ameddbqv2sehq3pp@skbuf>
 <8735jil0m1.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735jil0m1.fsf@waldekranz.com>
Subject: Re: [Bridge] [PATCH v4 net-next 10/15] net: dsa: Validate hardware
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
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Matt Johnston <matt@codeconstruct.com.au>, davem@davemloft.net, linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 10:15:18AM +0100, Tobias Waldekranz wrote:
> >> +int dsa_port_mst_enable(struct dsa_port *dp, bool on,
> >> +			struct netlink_ext_ack *extack)
> >> +{
> >> +	if (!on)
> >> +		return 0;
> >> +
> >> +	if (!dsa_port_supports_mst(dp)) {
> >> +		NL_SET_ERR_MSG_MOD(extack, "Hardware does not support MST");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >
> > Experimenting a bit... maybe this looks tidier? We make the "if" condition
> > have the same basic structure as the previous "if (br_mst_enabled(br) &&
> > !dsa_port_supports_mst(dp))", albeit transformed using De Morgan's rules.
> >
> > {
> > 	if (!on || dsa_port_supports_mst(dp))
> > 		return 0;
> >
> > 	NL_SET_ERR_MSG_MOD(extack, "Hardware does not support MST");
> > 	return -EINVAL;
> > }
> 
> I initially had it like this. It looks tidier, yes - but to me the
> intent is less obvious when reading it. How about:
> 
> {
> 	if (on && !dsa_port_supports_mst(dp)) {
> 		NL_SET_ERR_MSG_MOD(extack, "Hardware does not support MST");
> 		return -EINVAL;
> 	}
> 
> 	return 0;
> }

Yes, let's go with this.
