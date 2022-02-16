Return-Path: <linux+bridge=lists.linux-foundation.org@armlinux.org.uk>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tjvtg6e6rfEBajxf7gEQ25jMTSa3cr331jVbNJooOA0=; b=fRzh+dlUNwjRlxwNg3p81SGp3B
 iStgmRxGiJO6bKTyqJwOLl8g3KNUsuNbBJrLRQ7UilHK2F8X5sVUfqqLvgT4IA+wsrJTra5I0v0qY
 dyZ7dqySINcTzpwqnM0bGq/bbzCr879Q3scd+JS3+0YPwLeEp9erYpO0YXsup7ValRWBOpdquQBjz
 iFOyTAvMnuNfMkyx+WuYaKrh39IiHrhOcAKz5cLMGwOkIAMjOHDgej31lVHn85+QZtw0iya38+4ti
 pbyviRSYF7YV5Wuln6MXHB4eQXiXuZyPeAkYP2kV5rkjGEdQPeho+Dsp3yOU3Ccq5Yqw6OonUeJHf
 BSJUVR5g==;
Date: Wed, 16 Feb 2022 13:39:00 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
Message-ID: <Ygz+dNz1YvyiFpxa@shell.armlinux.org.uk>
References: <20220216132934.1775649-1-tobias@waldekranz.com>
 <20220216132934.1775649-10-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216132934.1775649-10-tobias@waldekranz.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Subject: Re: [Bridge] [RFC net-next 9/9] net: dsa: mv88e6xxx: MST Offloading
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

Hi,

On Wed, Feb 16, 2022 at 02:29:34PM +0100, Tobias Waldekranz wrote:
> +static int mv88e6xxx_sid_new(struct mv88e6xxx_chip *chip, u8 *sid)
> +{
> +	DECLARE_BITMAP(busy, MV88E6XXX_N_SID) = { 0 };
> +	struct mv88e6xxx_mst *mst;
> +
> +	set_bit(0, busy);
> +
> +	list_for_each_entry(mst, &chip->msts, node) {
> +		set_bit(mst->stu.sid, busy);
> +	}

Do you need these set_bit() operations to be atomic? Would __set_bit()
produce better code?

> +
> +	*sid = find_first_zero_bit(busy, MV88E6XXX_N_SID);
> +
> +	return (*sid >= mv88e6xxx_max_sid(chip)) ? -ENOSPC : 0;

Hmm. Let's hope that mv88e6xxx_max_sid() never returns a value larger
than MV88E6XXX_N_SID.

> +}
> +
...
> +static int mv88e6xxx_sid_get(struct mv88e6xxx_chip *chip, struct net_device *br,
> +			     u16 mstid, u8 *sid)
> +{
> +	struct mv88e6xxx_mst *mst;
> +	int err;
> +
> +	if (!br)
> +		return 0;
> +
> +	if (!mv88e6xxx_has_stu(chip))
> +		return -EOPNOTSUPP;
> +
> +	list_for_each_entry(mst, &chip->msts, node) {
> +		if (mst->br == br && mst->mstid == mstid) {
> +			refcount_inc(&mst->refcnt);
> +			*sid = mst->stu.sid;
> +			return 0;
> +		}
> +	}
> +
> +	err = mv88e6xxx_sid_new(chip, sid);
> +	if (err)
> +		return err;
> +
> +	mst = kzalloc(sizeof(*mst), GFP_KERNEL);
> +	if (!mst)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&mst->node);

There is no need to initialise the node if you're then going to be
adding it to the list.

> +	refcount_set(&mst->refcnt, 1);
> +	mst->br = br;
> +	mst->mstid = mstid;
> +	mst->stu.valid = true;
> +	mst->stu.sid = *sid;
> +	list_add_tail(&mst->node, &chip->msts);
> +	return mv88e6xxx_stu_loadpurge(chip, &mst->stu);

I haven't checked what the locking is here - I hope it's not possible
for two of these to run concurrently.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
