Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=7IKZuz89EQxHr0lzR2wMsnneD6Fn93b3bGH8OU7Rsk4=;
 b=Elrte59wDxxlsyUKi60alLHpFbkKHSESMcuNcLQOHw7cJCSfDJAAsmg6ttUGjf6bxy
 vpETVsH4lj8JmmBa3Rpol3LstZo7c+MOghyPI4Gg1y9XSWwnlCvLFhr/ZHV2lWOAOrpZ
 VR3zquWUI/oaYZmAnOoMOCZ1yq6EQeDeafzGTSvqE4XX0HuA5puEfjbGREi0eJoOUvJ9
 RSTxmMVOQnoBGryxQd0MzQ5r2UXB+5sobYA7bnZl7+7gaDsTZb029cB2Osmr58n9+IH+
 3gPyTx46C41TBw28fkPR4oR9Xq3PDIFzdRkmA72a8LtYafaT+v070GbmUENXmYEK2PCA
 y52A==
From: Tobias Waldekranz <tobias@waldekranz.com>
In-Reply-To: <20220314162716.fm4tpkdi4b4ak3th@skbuf>
References: <20220314095231.3486931-1-tobias@waldekranz.com>
 <20220314095231.3486931-15-tobias@waldekranz.com>
 <20220314162716.fm4tpkdi4b4ak3th@skbuf>
Date: Mon, 14 Mar 2022 22:57:48 +0100
Message-ID: <87k0cwkxib.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH v3 net-next 14/14] net: dsa: mv88e6xxx: MST
	Offloading
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

On Mon, Mar 14, 2022 at 18:27, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Mon, Mar 14, 2022 at 10:52:31AM +0100, Tobias Waldekranz wrote:
>> Allocate a SID in the STU for each MSTID in use by a bridge and handle
>> the mapping of MSTIDs to VLANs using the SID field of each VTU entry.
>> 
>> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>> ---
>>  drivers/net/dsa/mv88e6xxx/chip.c | 251 ++++++++++++++++++++++++++++++-
>>  drivers/net/dsa/mv88e6xxx/chip.h |  13 ++
>>  2 files changed, 257 insertions(+), 7 deletions(-)
>> 
>> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
>> index c14a62aa6a6c..c23dbf37aeec 100644
>> --- a/drivers/net/dsa/mv88e6xxx/chip.c
>> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
>> @@ -1667,24 +1667,32 @@ static int mv88e6xxx_pvt_setup(struct mv88e6xxx_chip *chip)
>>  	return 0;
>>  }
>>  
>> -static void mv88e6xxx_port_fast_age(struct dsa_switch *ds, int port)
>> +static void mv88e6xxx_port_fast_age_fid(struct mv88e6xxx_chip *chip, int port,
>> +					u16 fid)
>>  {
>> -	struct mv88e6xxx_chip *chip = ds->priv;
>>  	int err;
>>  
>> -	if (dsa_to_port(ds, port)->lag)
>> +	if (dsa_to_port(chip->ds, port)->lag)
>>  		/* Hardware is incapable of fast-aging a LAG through a
>>  		 * regular ATU move operation. Until we have something
>>  		 * more fancy in place this is a no-op.
>>  		 */
>>  		return;
>>  
>> -	mv88e6xxx_reg_lock(chip);
>> -	err = mv88e6xxx_g1_atu_remove(chip, 0, port, false);
>> -	mv88e6xxx_reg_unlock(chip);
>> +	err = mv88e6xxx_g1_atu_remove(chip, fid, port, false);
>>  
>>  	if (err)
>> -		dev_err(ds->dev, "p%d: failed to flush ATU\n", port);
>> +		dev_err(chip->ds->dev, "p%d: failed to flush ATU (FID %u)\n",
>> +			port, fid);
>> +}
>> +
>> +static void mv88e6xxx_port_fast_age(struct dsa_switch *ds, int port)
>> +{
>> +	struct mv88e6xxx_chip *chip = ds->priv;
>> +
>> +	mv88e6xxx_reg_lock(chip);
>> +	mv88e6xxx_port_fast_age_fid(chip, port, 0);
>> +	mv88e6xxx_reg_unlock(chip);
>>  }
>>  
>>  static int mv88e6xxx_vtu_setup(struct mv88e6xxx_chip *chip)
>> @@ -1818,6 +1826,159 @@ static int mv88e6xxx_stu_setup(struct mv88e6xxx_chip *chip)
>>  	return mv88e6xxx_stu_loadpurge(chip, &stu);
>>  }
>>  
>> +static int mv88e6xxx_sid_get(struct mv88e6xxx_chip *chip, u8 *sid)
>> +{
>> +	DECLARE_BITMAP(busy, MV88E6XXX_N_SID) = { 0 };
>> +	struct mv88e6xxx_mst *mst;
>> +
>> +	set_bit(0, busy);
>
> __set_bit
>

Ack

>> +
>> +	list_for_each_entry(mst, &chip->msts, node) {
>> +		set_bit(mst->stu.sid, busy);
>> +	}
>
> Up to you, but parentheses are generally not used for single-line blocks.
>

Ack

>> +
>> +	*sid = find_first_zero_bit(busy, MV88E6XXX_N_SID);
>> +
>> +	return (*sid >= mv88e6xxx_max_sid(chip)) ? -ENOSPC : 0;
>> +}
>> +
>> +static int mv88e6xxx_mst_put(struct mv88e6xxx_chip *chip, u8 sid)
>> +{
>> +	struct mv88e6xxx_mst *mst, *tmp;
>> +	int err;
>> +
>> +	if (!sid)
>> +		return 0;
>
> Very minor nitpick: since mv88e6xxx_mst_put already checks this, could
> you drop the "!sid" check from callers?

Dropping

>> +
>> +	list_for_each_entry_safe(mst, tmp, &chip->msts, node) {
>> +		if (mst->stu.sid != sid)
>> +			continue;
>> +
>> +		if (!refcount_dec_and_test(&mst->refcnt))
>> +			return 0;
>> +
>> +		mst->stu.valid = false;
>> +		err = mv88e6xxx_stu_loadpurge(chip, &mst->stu);
>> +		if (err)
>
> Should we bother with a refcount_set(&mst->refcount, 1) on error?

We might as well. Thanks.

>> +			return err;
>> +
>> +		list_del(&mst->node);
>> +		kfree(mst);
>> +		return 0;
>> +	}
>> +
>> +	return -ENOENT;
>> +}
>> +
>> +static int mv88e6xxx_mst_get(struct mv88e6xxx_chip *chip, struct net_device *br,
>> +			     u16 msti, u8 *sid)
>> +{
>> +	struct mv88e6xxx_mst *mst;
>> +	int err, i;
>> +
>> +	if (!mv88e6xxx_has_stu(chip)) {
>> +		err = -EOPNOTSUPP;
>> +		goto err;
>> +	}
>> +
>> +	if (!msti) {
>> +		*sid = 0;
>> +		return 0;
>> +	}
>> +
>> +	list_for_each_entry(mst, &chip->msts, node) {
>> +		if (mst->br == br && mst->msti == msti) {
>> +			refcount_inc(&mst->refcnt);
>> +			*sid = mst->stu.sid;
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	err = mv88e6xxx_sid_get(chip, sid);
>> +	if (err)
>> +		goto err;
>> +
>> +	mst = kzalloc(sizeof(*mst), GFP_KERNEL);
>> +	if (!mst) {
>> +		err = -ENOMEM;
>> +		goto err;
>> +	}
>> +
>> +	INIT_LIST_HEAD(&mst->node);
>> +	refcount_set(&mst->refcnt, 1);
>> +	mst->br = br;
>> +	mst->msti = msti;
>> +	mst->stu.valid = true;
>> +	mst->stu.sid = *sid;
>> +
>> +	/* The bridge starts out all ports in the disabled state. But
>> +	 * a STU state of disabled means to go by the port-global
>> +	 * state. So we set all user port's initial state to blocking,
>> +	 * to match the bridge's behavior.
>> +	 */
>> +	for (i = 0; i < mv88e6xxx_num_ports(chip); i++)
>> +		mst->stu.state[i] = dsa_is_user_port(chip->ds, i) ?
>> +			MV88E6XXX_PORT_CTL0_STATE_BLOCKING :
>> +			MV88E6XXX_PORT_CTL0_STATE_DISABLED;
>> +
>> +	err = mv88e6xxx_stu_loadpurge(chip, &mst->stu);
>> +	if (err)
>> +		goto err_free;
>> +
>> +	list_add_tail(&mst->node, &chip->msts);
>> +	return 0;
>> +
>> +err_free:
>> +	kfree(mst);
>> +err:
>> +	return err;
>> +}
>> +
>> +static int mv88e6xxx_port_mst_state_set(struct dsa_switch *ds, int port,
>> +					const struct switchdev_mst_state *st)
>> +{
>> +	struct dsa_port *dp = dsa_to_port(ds, port);
>> +	struct mv88e6xxx_chip *chip = ds->priv;
>> +	struct mv88e6xxx_mst *mst;
>> +	u8 state;
>> +	int err;
>> +
>> +	if (!mv88e6xxx_has_stu(chip))
>> +		return -EOPNOTSUPP;
>> +
>> +	switch (st->state) {
>> +	case BR_STATE_DISABLED:
>> +	case BR_STATE_BLOCKING:
>> +	case BR_STATE_LISTENING:
>> +		state = MV88E6XXX_PORT_CTL0_STATE_BLOCKING;
>> +		break;
>> +	case BR_STATE_LEARNING:
>> +		state = MV88E6XXX_PORT_CTL0_STATE_LEARNING;
>> +		break;
>> +	case BR_STATE_FORWARDING:
>> +		state = MV88E6XXX_PORT_CTL0_STATE_FORWARDING;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	list_for_each_entry(mst, &chip->msts, node) {
>> +		if (mst->br == dsa_port_bridge_dev_get(dp) &&
>> +		    mst->msti == st->msti) {
>> +			if (mst->stu.state[port] == state)
>> +				return 0;
>> +
>> +			mst->stu.state[port] = state;
>> +			mv88e6xxx_reg_lock(chip);
>> +			err = mv88e6xxx_stu_loadpurge(chip, &mst->stu);
>> +			mv88e6xxx_reg_unlock(chip);
>> +			return err;
>> +		}
>> +	}
>> +
>> +	return -ENOENT;
>> +}
>> +
>>  static int mv88e6xxx_port_check_hw_vlan(struct dsa_switch *ds, int port,
>>  					u16 vid)
>>  {
>> @@ -2437,6 +2598,12 @@ static int mv88e6xxx_port_vlan_leave(struct mv88e6xxx_chip *chip,
>>  	if (err)
>>  		return err;
>>  
>> +	if (!vlan.valid && vlan.sid) {
>> +		err = mv88e6xxx_mst_put(chip, vlan.sid);
>> +		if (err)
>> +			return err;
>> +	}
>> +
>>  	return mv88e6xxx_g1_atu_remove(chip, vlan.fid, port, false);
>>  }
>>  
>> @@ -2482,6 +2649,72 @@ static int mv88e6xxx_port_vlan_del(struct dsa_switch *ds, int port,
>>  	return err;
>>  }
>>  
>> +static void mv88e6xxx_port_vlan_fast_age(struct dsa_switch *ds, int port, u16 vid)
>> +{
>> +	struct mv88e6xxx_chip *chip = ds->priv;
>> +	struct mv88e6xxx_vtu_entry vlan;
>> +	int err;
>> +
>> +	mv88e6xxx_reg_lock(chip);
>> +
>> +	err = mv88e6xxx_vtu_get(chip, vid, &vlan);
>> +	if (err)
>> +		goto unlock;
>> +
>> +	mv88e6xxx_port_fast_age_fid(chip, port, vlan.fid);
>> +
>> +unlock:
>> +	mv88e6xxx_reg_unlock(chip);
>> +
>> +	if (err)
>> +		dev_err(ds->dev, "p%d: failed to flush ATU in VID %u\n",
>> +			port, vid);
>
> This error message actually corresponds to an mv88e6xxx_vtu_get() error,
> so the message is kind of incorrect. mv88e6xxx_port_fast_age_fid(),
> whose error code isn't propagated here, has its own "failed to flush ATU"
> error message.

Not sure I agree. If this fails, the symptom will be lingering dynamic
entries in the affected VLAN. In that case I think the current message,
or something similar, will make it as easy as possible to establish a
correlation.

Yes, it failed because the VTU get op failed, but that is more of an
internal affair in the driver.

Anyway, it's a moot point, because I think we should just allow the
error to bubble up to userspace instead - as you suggested in 11/14.

>> +}
>
> Otherwise this looks pretty good.

Careful now, don't spoil me :)
