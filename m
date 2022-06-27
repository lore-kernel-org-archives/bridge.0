Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CDDFF40162
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7E82C400C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=1ytXLAJrg+4TK16uWTX2vGK+3zgwRA2Qgaue1pRVJ3A=;
 b=K/BOOtBzA1IsKkam+aDs/eICZe34nLYUuc1NU4yWwCkUkUJ37IfMGGxrJR+0olqp5g
 48lT06g8Wn9urdRlKaeuZott5wn7i65oK8jHea9WTyNFRJCgthX+qlOqvxAI/vOa+j/S
 ikNZ6IpVKslYB/OPu9xekVJnIdKQi5vRYgIZqRlVacOgtpGLpMy9PLhnhs3JASjWx6yN
 0c/594xKv7RhV14nXshU5TGl/SW3APDJ3C88cZvEaxymkAHnCHkBGHvjLshpK6ezYo0P
 VkbSmzTc4MSpu2Mz0pApai6Go44g2rqUH3o8aT+NYbBjWufgTpDq3uAciSRjO04V/3Ov
 oC+g==
Date: Mon, 27 Jun 2022 21:05:57 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220627180557.xnxud7d6ol22lexb@skbuf>
References: <20220524152144.40527-1-schultz.hans+netdev@gmail.com>
 <20220524152144.40527-4-schultz.hans+netdev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524152144.40527-4-schultz.hans+netdev@gmail.com>
Subject: Re: [Bridge] [PATCH V3 net-next 3/4] net: dsa: mv88e6xxx:
 mac-auth/MAB implementation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <schultz.hans@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Hans Schultz <schultz.hans+netdev@gmail.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net, linux-kernel@vger.kernel.org

Hi Hans,

On Tue, May 24, 2022 at 05:21:43PM +0200, Hans Schultz wrote:
> This implementation for the Marvell mv88e6xxx chip series, is
> based on handling ATU miss violations occurring when packets
> ingress on a port that is locked. The mac address triggering
> the ATU miss violation is communicated through switchdev to
> the bridge module, which adds a fdb entry with the fdb locked
> flag set. The entry is kept according to the bridges ageing
> time, thus simulating a dynamic entry.
> 
> Note: The locked port must have learning enabled for the ATU
> miss violation to occur.
> 
> Signed-off-by: Hans Schultz <schultz.hans+netdev@gmail.com>
> ---

I'm sorry that I couldn't focus on the big picture of this patch,
but locking is an absolute disaster and I just stopped after a while,
it's really distracting :)

Would you mind addressing the feedback below first, and I'll take
another look when you send v4?

>  drivers/net/dsa/mv88e6xxx/Makefile            |   1 +
>  drivers/net/dsa/mv88e6xxx/chip.c              |  40 ++-
>  drivers/net/dsa/mv88e6xxx/chip.h              |   5 +
>  drivers/net/dsa/mv88e6xxx/global1.h           |   1 +
>  drivers/net/dsa/mv88e6xxx/global1_atu.c       |  35 ++-
>  .../net/dsa/mv88e6xxx/mv88e6xxx_switchdev.c   | 249 ++++++++++++++++++
>  .../net/dsa/mv88e6xxx/mv88e6xxx_switchdev.h   |  40 +++
>  drivers/net/dsa/mv88e6xxx/port.c              |  32 ++-
>  drivers/net/dsa/mv88e6xxx/port.h              |   2 +
>  9 files changed, 389 insertions(+), 16 deletions(-)
>  create mode 100644 drivers/net/dsa/mv88e6xxx/mv88e6xxx_switchdev.c
>  create mode 100644 drivers/net/dsa/mv88e6xxx/mv88e6xxx_switchdev.h
> 
> diff --git a/drivers/net/dsa/mv88e6xxx/Makefile b/drivers/net/dsa/mv88e6xxx/Makefile
> index c8eca2b6f959..3ca57709730d 100644
> --- a/drivers/net/dsa/mv88e6xxx/Makefile
> +++ b/drivers/net/dsa/mv88e6xxx/Makefile
> @@ -15,3 +15,4 @@ mv88e6xxx-objs += port_hidden.o
>  mv88e6xxx-$(CONFIG_NET_DSA_MV88E6XXX_PTP) += ptp.o
>  mv88e6xxx-objs += serdes.o
>  mv88e6xxx-objs += smi.o
> +mv88e6xxx-objs += mv88e6xxx_switchdev.o
> \ No newline at end of file
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> index 5d2c57a7c708..f7a16886bee9 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -42,6 +42,7 @@
>  #include "ptp.h"
>  #include "serdes.h"
>  #include "smi.h"
> +#include "mv88e6xxx_switchdev.h"
>  
>  static void assert_reg_lock(struct mv88e6xxx_chip *chip)
>  {
> @@ -919,6 +920,9 @@ static void mv88e6xxx_mac_link_down(struct dsa_switch *ds, int port,
>  	if (err)
>  		dev_err(chip->dev,
>  			"p%d: failed to force MAC link down\n", port);
> +	else
> +		if (mv88e6xxx_port_is_locked(chip, port, true))
> +			mv88e6xxx_atu_locked_entry_flush(ds, port);

This is superfluous, is it not? The bridge will transition a port whose
link goes down to BR_STATE_DISABLED, which will make dsa_port_set_state()
fast-age the dynamic FDB entries on the port, which you've already
handled below.

>  }
>  
>  static void mv88e6xxx_mac_link_up(struct dsa_switch *ds, int port,
> @@ -1685,6 +1689,9 @@ static void mv88e6xxx_port_fast_age(struct dsa_switch *ds, int port)
>  	struct mv88e6xxx_chip *chip = ds->priv;
>  	int err;
>  
> +	if (mv88e6xxx_port_is_locked(chip, port, true))
> +		mv88e6xxx_atu_locked_entry_flush(ds, port);
> +

Dumb question: if you only flush the locked entries at fast age if the
port is locked, then what happens with the existing locked entries if
the port becomes unlocked before an FDB flush takes place?
Shouldn't mv88e6xxx_port_set_lock() call mv88e6xxx_atu_locked_entry_flush()
too?

>  	mv88e6xxx_reg_lock(chip);
>  	err = mv88e6xxx_port_fast_age_fid(chip, port, 0);
>  	mv88e6xxx_reg_unlock(chip);
> @@ -1721,11 +1728,11 @@ static int mv88e6xxx_vtu_get(struct mv88e6xxx_chip *chip, u16 vid,
>  	return err;
>  }
>  
> -static int mv88e6xxx_vtu_walk(struct mv88e6xxx_chip *chip,
> -			      int (*cb)(struct mv88e6xxx_chip *chip,
> -					const struct mv88e6xxx_vtu_entry *entry,
> -					void *priv),
> -			      void *priv)
> +int mv88e6xxx_vtu_walk(struct mv88e6xxx_chip *chip,
> +		       int (*cb)(struct mv88e6xxx_chip *chip,
> +				 const struct mv88e6xxx_vtu_entry *entry,
> +				 void *priv),
> +		       void *priv)
>  {
>  	struct mv88e6xxx_vtu_entry entry = {
>  		.vid = mv88e6xxx_max_vid(chip),
> @@ -2722,9 +2729,12 @@ static int mv88e6xxx_port_fdb_add(struct dsa_switch *ds, int port,
>  	struct mv88e6xxx_chip *chip = ds->priv;
>  	int err;
>  
> +	if (mv88e6xxx_port_is_locked(chip, port, true))
> +		mv88e6xxx_atu_locked_entry_find_purge(ds, port, addr, vid);
> +
>  	mv88e6xxx_reg_lock(chip);
>  	err = mv88e6xxx_port_db_load_purge(chip, port, addr, vid,
> -					   MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC);
> +			MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC);

Unrelated and unjustified change.

>  	mv88e6xxx_reg_unlock(chip);
>  
>  	return err;
> @@ -2735,12 +2745,17 @@ static int mv88e6xxx_port_fdb_del(struct dsa_switch *ds, int port,
>  				  struct dsa_db db)
>  {
>  	struct mv88e6xxx_chip *chip = ds->priv;
> +	bool locked_found = false;
>  	int err;
>  
> -	mv88e6xxx_reg_lock(chip);
> -	err = mv88e6xxx_port_db_load_purge(chip, port, addr, vid, 0);
> -	mv88e6xxx_reg_unlock(chip);
> +	if (mv88e6xxx_port_is_locked(chip, port, true))
> +		locked_found = mv88e6xxx_atu_locked_entry_find_purge(ds, port, addr, vid);
>  
> +	if (!locked_found) {
> +		mv88e6xxx_reg_lock(chip);
> +		err = mv88e6xxx_port_db_load_purge(chip, port, addr, vid, 0);
> +		mv88e6xxx_reg_unlock(chip);
> +	}
>  	return err;
>  }
>  
> @@ -3809,11 +3824,16 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
>  
>  static int mv88e6xxx_port_setup(struct dsa_switch *ds, int port)
>  {
> -	return mv88e6xxx_setup_devlink_regions_port(ds, port);
> +	int err;
> +
> +	err = mv88e6xxx_setup_devlink_regions_port(ds, port);
> +	mv88e6xxx_init_violation_handler(ds, port);

What's with this quirky placement? You need to do error checking and
call mv88e6xxx_teardown_violation_handler() if setting up the devlink
port regions fails, otherwise the port will fail to probe but no one
will quiesce its delayed ATU work.

By the way, do all mv88e6xxx switches support 802.1X and MAC Auth Bypass,
or do we need to initialize these structures depending on some capability?

> +	return err;
>  }
>  
>  static void mv88e6xxx_port_teardown(struct dsa_switch *ds, int port)
>  {
> +	mv88e6xxx_teardown_violation_handler(ds, port);
>  	mv88e6xxx_teardown_devlink_regions_port(ds, port);
>  }
>  
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
> index 5e03cfe50156..c9a8404a6293 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.h
> +++ b/drivers/net/dsa/mv88e6xxx/chip.h
> @@ -803,6 +803,11 @@ static inline void mv88e6xxx_reg_unlock(struct mv88e6xxx_chip *chip)
>  	mutex_unlock(&chip->reg_lock);
>  }
>  
> +int mv88e6xxx_vtu_walk(struct mv88e6xxx_chip *chip,
> +		       int (*cb)(struct mv88e6xxx_chip *chip,
> +				 const struct mv88e6xxx_vtu_entry *entry,
> +				 void *priv),
> +		       void *priv);
>  int mv88e6xxx_fid_map(struct mv88e6xxx_chip *chip, unsigned long *bitmap);
>  
>  #endif /* _MV88E6XXX_CHIP_H */
> diff --git a/drivers/net/dsa/mv88e6xxx/global1.h b/drivers/net/dsa/mv88e6xxx/global1.h
> index 65958b2a0d3a..503fbf216670 100644
> --- a/drivers/net/dsa/mv88e6xxx/global1.h
> +++ b/drivers/net/dsa/mv88e6xxx/global1.h
> @@ -136,6 +136,7 @@
>  #define MV88E6XXX_G1_ATU_DATA_TRUNK				0x8000
>  #define MV88E6XXX_G1_ATU_DATA_TRUNK_ID_MASK			0x00f0
>  #define MV88E6XXX_G1_ATU_DATA_PORT_VECTOR_MASK			0x3ff0
> +#define MV88E6XXX_G1_ATU_DATA_PORT_VECTOR_NO_EGRESS		0x0000
>  #define MV88E6XXX_G1_ATU_DATA_STATE_MASK			0x000f
>  #define MV88E6XXX_G1_ATU_DATA_STATE_UC_UNUSED			0x0000
>  #define MV88E6XXX_G1_ATU_DATA_STATE_UC_AGE_1_OLDEST		0x0001
> diff --git a/drivers/net/dsa/mv88e6xxx/global1_atu.c b/drivers/net/dsa/mv88e6xxx/global1_atu.c
> index 40bd67a5c8e9..517376271f64 100644
> --- a/drivers/net/dsa/mv88e6xxx/global1_atu.c
> +++ b/drivers/net/dsa/mv88e6xxx/global1_atu.c
> @@ -12,6 +12,8 @@
>  
>  #include "chip.h"
>  #include "global1.h"
> +#include "port.h"
> +#include "mv88e6xxx_switchdev.h"
>  
>  /* Offset 0x01: ATU FID Register */
>  
> @@ -114,6 +116,18 @@ static int mv88e6xxx_g1_atu_op_wait(struct mv88e6xxx_chip *chip)
>  	return mv88e6xxx_g1_wait_bit(chip, MV88E6XXX_G1_ATU_OP, bit, 0);
>  }
>  
> +static int mv88e6xxx_g1_read_atu_violation(struct mv88e6xxx_chip *chip)
> +{
> +	int err;
> +
> +	err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_ATU_OP,
> +				 MV88E6XXX_G1_ATU_OP_BUSY | MV88E6XXX_G1_ATU_OP_GET_CLR_VIOLATION);

Split on 3 lines please.

> +	if (err)
> +		return err;
> +
> +	return mv88e6xxx_g1_atu_op_wait(chip);
> +}
> +
>  static int mv88e6xxx_g1_atu_op(struct mv88e6xxx_chip *chip, u16 fid, u16 op)
>  {
>  	u16 val;
> @@ -356,11 +370,11 @@ static irqreturn_t mv88e6xxx_g1_atu_prob_irq_thread_fn(int irq, void *dev_id)
>  	int spid;
>  	int err;
>  	u16 val;
> +	u16 fid;
>  
>  	mv88e6xxx_reg_lock(chip);
>  
> -	err = mv88e6xxx_g1_atu_op(chip, 0,
> -				  MV88E6XXX_G1_ATU_OP_GET_CLR_VIOLATION);
> +	err = mv88e6xxx_g1_read_atu_violation(chip);

I cannot comment on the validity of this change: previously, we were
writing FID 0 as part of mv88e6xxx_g1_atu_op(), now we are reading back
the FID. Definitely too much going on in a single change, this needs a
separate patch with an explanation.

>  	if (err)
>  		goto out;
>  
> @@ -368,6 +382,10 @@ static irqreturn_t mv88e6xxx_g1_atu_prob_irq_thread_fn(int irq, void *dev_id)
>  	if (err)
>  		goto out;
>  
> +	err = mv88e6xxx_g1_read(chip, MV88E6352_G1_ATU_FID, &fid);
> +	if (err)
> +		goto out;

Is it ok to read the MV88E6352_G1_ATU_FID register from an IRQ handler
common for all switches, I wonder?

> +
>  	err = mv88e6xxx_g1_atu_data_read(chip, &entry);
>  	if (err)
>  		goto out;
> @@ -382,6 +400,11 @@ static irqreturn_t mv88e6xxx_g1_atu_prob_irq_thread_fn(int irq, void *dev_id)
>  		dev_err_ratelimited(chip->dev,
>  				    "ATU age out violation for %pM\n",
>  				    entry.mac);
> +		err = mv88e6xxx_handle_violation(chip,
> +						 chip->ports[spid].port,

Dumb question: isn't chip->ports[spid].port == spid?

> +						 &entry,
> +						 fid,
> +						 MV88E6XXX_G1_ATU_OP_AGE_OUT_VIOLATION);

This fits on 3 lines instead of 5 (and same below).

>  	}
>  
>  	if (val & MV88E6XXX_G1_ATU_OP_MEMBER_VIOLATION) {
> @@ -396,6 +419,14 @@ static irqreturn_t mv88e6xxx_g1_atu_prob_irq_thread_fn(int irq, void *dev_id)
>  				    "ATU miss violation for %pM portvec %x spid %d\n",
>  				    entry.mac, entry.portvec, spid);
>  		chip->ports[spid].atu_miss_violation++;
> +		if (mv88e6xxx_port_is_locked(chip, chip->ports[spid].port, false))
> +			err = mv88e6xxx_handle_violation(chip,
> +							 chip->ports[spid].port,
> +							 &entry,
> +							 fid,
> +							 MV88E6XXX_G1_ATU_OP_MISS_VIOLATION);
> +		if (err)
> +			goto out;
>  	}
>  
>  	if (val & MV88E6XXX_G1_ATU_OP_FULL_VIOLATION) {
> diff --git a/drivers/net/dsa/mv88e6xxx/mv88e6xxx_switchdev.c b/drivers/net/dsa/mv88e6xxx/mv88e6xxx_switchdev.c
> new file mode 100644
> index 000000000000..8436655ceb9a
> --- /dev/null
> +++ b/drivers/net/dsa/mv88e6xxx/mv88e6xxx_switchdev.c
> @@ -0,0 +1,249 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * mv88e6xxx_switchdev.c
> + *
> + *	Authors:
> + *	Hans J. Schultz		<hans.schultz@westermo.com>
> + *
> + */
> +
> +#include <net/switchdev.h>
> +#include <linux/list.h>
> +#include "chip.h"
> +#include "global1.h"
> +#include "mv88e6xxx_switchdev.h"
> +
> +static void mv88e6xxx_atu_locked_entry_timer_work(struct atu_locked_entry *ale)

Please find a more adequate name for this function.

> +{
> +	struct switchdev_notifier_fdb_info info = {
> +		.addr = ale->mac,
> +		.vid = ale->vid,
> +		.added_by_user = false,
> +		.is_local = false,

No need to have an initializer for the false members.

> +		.offloaded = true,
> +		.locked = true,
> +	};
> +	struct mv88e6xxx_atu_entry entry;
> +	struct net_device *brport;
> +	struct dsa_port *dp;
> +
> +	entry.state = MV88E6XXX_G1_ATU_DATA_STATE_UC_UNUSED;
> +	entry.trunk = false;
> +	memcpy(&entry.mac, &ale->mac, ETH_ALEN);

ether_addr_copy

> +
> +	mv88e6xxx_reg_lock(ale->chip);
> +	mv88e6xxx_g1_atu_loadpurge(ale->chip, ale->fid, &entry);

The portvec will be junk memory that's on stack, is that what you want?

> +	mv88e6xxx_reg_unlock(ale->chip);
> +
> +	dp = dsa_to_port(ale->chip->ds, ale->port);
> +	brport = dsa_port_to_bridge_port(dp);
> +
> +	if (brport) {
> +		if (!rtnl_is_locked()) {
> +			rtnl_lock();

No, no, no, no, no, no, no.

As I've explained already:
https://patchwork.kernel.org/project/netdevbpf/patch/20220317093902.1305816-4-schultz.hans+netdev@gmail.com/#24782974
dsa_port_to_bridge_port() needs to be called with the rtnl_mutex held.

Please take a moment to figure out which function expects which lock and
for what operation, then draw a call graph, figure out a consistent lock
hierarchy where things are always acquired in the same order, and if a
function needs a locking context but not all callers offer it, put an
ASSERT_RTNL() (for example) and transfer the locking responsibility to
the caller.

Doing this will also help you name your functions better than
"locked entry timer work" (which are called from... drum roll...
mv88e6xxx_port_fdb_del and mv88e6xxx_port_fast_age).

Which by the way, reminds me that.....
You can't take rtnl_lock() from port_fdb_add() and port_fdb_del(),
see commits d7d0d423dbaa ("net: dsa: flush switchdev workqueue when
leaving the bridge") and 0faf890fc519 ("net: dsa: drop rtnl_lock from
dsa_slave_switchdev_event_work"), as you'll deadlock with
dsa_port_pre_bridge_leave(). In fact you never could, but for a slightly
different reason.

From the discussion with Ido and Nikolay I get the impression that
you're not doing the right thing here either, notifying a
SWITCHDEV_FDB_DEL_TO_BRIDGE from what is effectively the
SWITCHDEV_FDB_DEL_TO_DEVICE handler (port_fdb_del).

> +			call_switchdev_notifiers(SWITCHDEV_FDB_DEL_TO_BRIDGE,
> +						 brport, &info.info, NULL);
> +			rtnl_unlock();
> +		} else {
> +			call_switchdev_notifiers(SWITCHDEV_FDB_DEL_TO_BRIDGE,
> +						 brport, &info.info, NULL);
> +		}
> +	} else {
> +		dev_err(ale->chip->dev, "ERR: No bridge port for dsa port belonging to port %d\n",
> +			ale->port);
> +	}
> +}
> +
> +static inline void mv88e6xxx_atu_locked_entry_purge(struct atu_locked_entry *ale)

No inline functions in .c files.

> +{
> +	mv88e6xxx_atu_locked_entry_timer_work(ale);
> +	del_timer(&ale->timer);
> +	list_del(&ale->list);
> +	kfree(ale);
> +}
> +
> +static void mv88e6xxx_atu_locked_entry_cleanup(struct work_struct *work)
> +{
> +	struct dsa_port *dp = container_of(work, struct dsa_port, atu_work.work);
> +	struct atu_locked_entry *ale, *tmp;
> +
> +	mutex_lock(&dp->locked_entries_list_lock);
> +	list_for_each_entry_safe(ale, tmp, &dp->atu_locked_entries_list, list) {
> +		if (ale->timed_out) {
> +			mv88e6xxx_atu_locked_entry_purge(ale);

Nasty lock ordering inversion. In mv88e6xxx_handle_violation() we take
&dp->locked_entries_list_lock with mv88e6xxx_reg_lock() held.
Here (in mv88e6xxx_atu_locked_entry_timer_work called from here) we take
mv88e6xxx_reg_lock() with &dp->locked_entries_list_lock held.

> +			atomic_dec(&dp->atu_locked_entry_cnt);
> +		}
> +	}
> +	mutex_unlock(&dp->locked_entries_list_lock);
> +
> +	mod_delayed_work(system_long_wq, &dp->atu_work, msecs_to_jiffies(100));
> +}
> +
> +static void mv88e6xxx_atu_locked_entry_timer_handler(struct timer_list *t)
> +{
> +	struct atu_locked_entry *ale = from_timer(ale, t, timer);
> +
> +	if (ale)
> +		ale->timed_out = true;
> +}
> +
> +struct mv88e6xxx_fid_search_ctx {
> +	u16 fid_search;
> +	u16 vid_found;
> +};
> +
> +static int mv88e6xxx_find_vid_on_matching_fid(struct mv88e6xxx_chip *chip,
> +					      const struct mv88e6xxx_vtu_entry *entry,
> +					      void *priv)
> +{
> +	struct mv88e6xxx_fid_search_ctx *ctx = priv;
> +
> +	if (ctx->fid_search == entry->fid) {
> +		ctx->vid_found = entry->vid;
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +int mv88e6xxx_handle_violation(struct mv88e6xxx_chip *chip,
> +			       int port,
> +			       struct mv88e6xxx_atu_entry *entry,
> +			       u16 fid,
> +			       u16 type)
> +{
> +	struct switchdev_notifier_fdb_info info = {
> +		.addr = entry->mac,
> +		.vid = 0,
> +		.added_by_user = false,
> +		.is_local = false,
> +		.offloaded = true,
> +		.locked = true,
> +	};
> +	struct atu_locked_entry *locked_entry;
> +	struct mv88e6xxx_fid_search_ctx ctx;
> +	struct net_device *brport;
> +	struct dsa_port *dp;
> +	int err;
> +
> +	ctx.fid_search = fid;
> +	err = mv88e6xxx_vtu_walk(chip, mv88e6xxx_find_vid_on_matching_fid, &ctx);
> +	if (err < 0)
> +		return err;
> +	if (err == 1)
> +		info.vid = ctx.vid_found;
> +	else
> +		return -ENODATA;
> +
> +	dp = dsa_to_port(chip->ds, port);
> +	brport = dsa_port_to_bridge_port(dp);
> +
> +	if (!brport)
> +		return -ENODEV;
> +
> +	switch (type) {
> +	case MV88E6XXX_G1_ATU_OP_MISS_VIOLATION:
> +		if (atomic_read(&dp->atu_locked_entry_cnt) >= ATU_LOCKED_ENTRIES_MAX) {
> +			mv88e6xxx_reg_unlock(chip);

You call mv88e6xxx_reg_lock() from mv88e6xxx_g1_atu_prob_irq_thread_fn()
and mv88e6xxx_reg_unlock() from mv88e6xxx_handle_violation()? Nice!

And I understand why that is: to avoid a lock ordering inversion with
rtnl_lock(). Just unlock the mv88e6xxx registers after the last hardware
access in mv88e6xxx_g1_atu_prob_irq_thread_fn() - after mv88e6xxx_g1_atu_mac_read(),
and call mv88e6xxx_handle_violation() with the registers unlocked, and
lock them when you need them.

> +			return 0;
> +		}
> +		entry->portvec = MV88E6XXX_G1_ATU_DATA_PORT_VECTOR_NO_EGRESS;
> +		entry->state = MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC;
> +		entry->trunk = false;
> +		err = mv88e6xxx_g1_atu_loadpurge(chip, fid, entry);
> +		if (err)
> +			goto fail;
> +
> +		locked_entry = kmalloc(sizeof(*locked_entry), GFP_ATOMIC);

Please be consistent in your naming of struct atu_locked_entry
variables, be they "locked_entry" or "ale" or otherwise.
And please create a helper function that creates such a structure and
initializes it.

> +		if (!locked_entry)
> +			return -ENOMEM;
> +		timer_setup(&locked_entry->timer, mv88e6xxx_atu_locked_entry_timer_handler, 0);

Does this have to be a dedicated timer per entry, or can you just record
the "jiffies" at creation time per locked entry, and compare it with the
current jiffies from the periodic, sleepable mv88e6xxx_atu_locked_entry_cleanup?

> +		locked_entry->timer.expires = jiffies + dp->ageing_time / 10;
> +		locked_entry->chip = chip;
> +		locked_entry->port = port;
> +		locked_entry->fid = fid;
> +		locked_entry->vid = info.vid;
> +		locked_entry->timed_out = false;
> +		memcpy(&locked_entry->mac, entry->mac, ETH_ALEN);
> +
> +		mutex_lock(&dp->locked_entries_list_lock);
> +		add_timer(&locked_entry->timer);
> +		list_add(&locked_entry->list, &dp->atu_locked_entries_list);
> +		mutex_unlock(&dp->locked_entries_list_lock);
> +		atomic_inc(&dp->atu_locked_entry_cnt);
> +
> +		mv88e6xxx_reg_unlock(chip);
> +
> +		rtnl_lock();
> +		err = call_switchdev_notifiers(SWITCHDEV_FDB_ADD_TO_BRIDGE,
> +					       brport, &info.info, NULL);
> +		break;
> +	}
> +	rtnl_unlock();

Why is the rtnl_unlock() outside the switch statement but the rtnl_lock() inside?
Not to mention, the dsa_port_to_bridge_port() call needs to be under rtnl_lock().

> +
> +	return err;
> +
> +fail:
> +	mv88e6xxx_reg_unlock(chip);
> +	return err;
> +}
> +
> +bool mv88e6xxx_atu_locked_entry_find_purge(struct dsa_switch *ds, int port,
> +					   const unsigned char *addr, u16 vid)
> +{
> +	struct dsa_port *dp = dsa_to_port(ds, port);
> +	struct atu_locked_entry *ale, *tmp;
> +	bool found = false;
> +
> +	mutex_lock(&dp->locked_entries_list_lock);
> +	list_for_each_entry_safe(ale, tmp, &dp->atu_locked_entries_list, list) {
> +		if (!memcmp(&ale->mac, addr, ETH_ALEN)) {
> +			if (ale->vid == vid) {
> +				mv88e6xxx_atu_locked_entry_purge(ale);
> +				atomic_dec(&dp->atu_locked_entry_cnt);
> +				found = true;
> +				break;
> +			}
> +		}
> +	}
> +	mutex_unlock(&dp->locked_entries_list_lock);
> +	return found;
> +}
> +
> +void mv88e6xxx_atu_locked_entry_flush(struct dsa_switch *ds, int port)
> +{
> +	struct dsa_port *dp = dsa_to_port(ds, port);
> +	struct atu_locked_entry *ale, *tmp;
> +
> +	mutex_lock(&dp->locked_entries_list_lock);
> +	list_for_each_entry_safe(ale, tmp, &dp->atu_locked_entries_list, list) {
> +		mv88e6xxx_atu_locked_entry_purge(ale);
> +		atomic_dec(&dp->atu_locked_entry_cnt);
> +	}
> +	mutex_unlock(&dp->locked_entries_list_lock);
> +
> +	if (atomic_read(&dp->atu_locked_entry_cnt) != 0)
> +		dev_err(ds->dev,
> +			"ERROR: Locked entries count is not zero after flush on port %d\n",
> +			port);

And generally speaking, why would you expect it to be 0, since there's
nothing that stops this check from racing with mv88e6xxx_handle_violation?
I suspect that if locking is properly thought through, the atu_locked_entry_cnt
can just be a plain int instead of an improperly used atomic.

Also, random fact: no need to say ERROR when printing with the KERN_ERR
log level. It's kind of implied from the log level.

> +}
> +
> +void mv88e6xxx_init_violation_handler(struct dsa_switch *ds, int port)
> +{
> +	struct dsa_port *dp = dsa_to_port(ds, port);
> +
> +	INIT_LIST_HEAD(&dp->atu_locked_entries_list);
> +	mutex_init(&dp->locked_entries_list_lock);
> +	dp->atu_locked_entry_cnt.counter = 0;

atomic_set()

> +	INIT_DELAYED_WORK(&dp->atu_work, mv88e6xxx_atu_locked_entry_cleanup);
> +	mod_delayed_work(system_long_wq, &dp->atu_work, msecs_to_jiffies(100));
> +}
> +
> +void mv88e6xxx_teardown_violation_handler(struct dsa_switch *ds, int port)
> +{
> +	struct dsa_port *dp = dsa_to_port(ds, port);
> +
> +	cancel_delayed_work(&dp->atu_work);
> +	mv88e6xxx_atu_locked_entry_flush(ds, port);
> +	mutex_destroy(&dp->locked_entries_list_lock);
> +}
> diff --git a/drivers/net/dsa/mv88e6xxx/mv88e6xxx_switchdev.h b/drivers/net/dsa/mv88e6xxx/mv88e6xxx_switchdev.h

This and mv88e6xxx_switchdev.c are the only source files belonging to
this driver which have the mv88e6xxx_ prefix (others are "chip.c" etc).
Can you please follow the convention?

> new file mode 100644
> index 000000000000..f0e7abf7c361
> --- /dev/null
> +++ b/drivers/net/dsa/mv88e6xxx/mv88e6xxx_switchdev.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * mv88e6xxx_switchdev.h
> + *
> + *	Authors:
> + *	Hans J. Schultz		<hans.schultz@westermo.com>
> + *
> + */
> +
> +#ifndef DRIVERS_NET_DSA_MV88E6XXX_MV88E6XXX_SWITCHDEV_H_
> +#define DRIVERS_NET_DSA_MV88E6XXX_MV88E6XXX_SWITCHDEV_H_
> +
> +#include <net/switchdev.h>
> +#include "chip.h"
> +
> +#define ATU_LOCKED_ENTRIES_MAX	64
> +
> +struct atu_locked_entry {

mv88e6xxx driver specific structure names should be prefixed with mv88e6xxx_.

> +	struct list_head list;
> +	struct mv88e6xxx_chip *chip;
> +	int port;
> +	u8	mac[ETH_ALEN];

Either align everything with tabs, or nothing.

> +	u16 fid;
> +	u16 vid;
> +	struct timer_list timer;
> +	bool timed_out;
> +};
> +
> +int mv88e6xxx_handle_violation(struct mv88e6xxx_chip *chip,
> +			       int port,
> +			       struct mv88e6xxx_atu_entry *entry,
> +			       u16 fid,
> +			       u16 type);

Both this and the function definition can easily fit on 3 lines.

> +bool mv88e6xxx_atu_locked_entry_find_purge(struct dsa_switch *ds, int port,
> +					   const unsigned char *addr, u16 vid);
> +void mv88e6xxx_atu_locked_entry_flush(struct dsa_switch *ds, int port);
> +void mv88e6xxx_init_violation_handler(struct dsa_switch *ds, int port);
> +void mv88e6xxx_teardown_violation_handler(struct dsa_switch *ds, int port);
> +
> +#endif /* DRIVERS_NET_DSA_MV88E6XXX_MV88E6XXX_SWITCHDEV_H_ */
> diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
> index 795b3128768f..c4e5e7174129 100644
> --- a/drivers/net/dsa/mv88e6xxx/port.c
> +++ b/drivers/net/dsa/mv88e6xxx/port.c
> @@ -14,9 +14,11 @@
>  #include <linux/phylink.h>
>  
>  #include "chip.h"
> +#include "global1.h"
>  #include "global2.h"
>  #include "port.h"
>  #include "serdes.h"
> +#include "mv88e6xxx_switchdev.h"
>  
>  int mv88e6xxx_port_read(struct mv88e6xxx_chip *chip, int port, int reg,
>  			u16 *val)
> @@ -1239,6 +1241,25 @@ int mv88e6xxx_port_set_mirror(struct mv88e6xxx_chip *chip, int port,
>  	return err;
>  }
>  
> +bool mv88e6xxx_port_is_locked(struct mv88e6xxx_chip *chip, int port, bool chiplock)
> +{
> +	bool locked = false;
> +	u16 reg;
> +
> +	if (chiplock)
> +		mv88e6xxx_reg_lock(chip);

Please, no "if (chiplock) mutex_lock()" hacks. Just lockdep_assert_held(&chip->reg_lock),
which serves both for documentation and for validation purposes, ensure
the lock is always taken at the caller (which in this case is super easy)
and move on.

> +
> +	if (mv88e6xxx_port_read(chip, port, MV88E6XXX_PORT_CTL0, &reg))
> +		goto out;

It would be good to actually propagate the error to the caller and
"locked" via a pass-by-reference bool pointer argument, not just say
that I/O errors mean that the port is unlocked.

> +	locked = reg & MV88E6XXX_PORT_CTL0_SA_FILT_DROP_ON_LOCK;
> +
> +out:
> +	if (chiplock)
> +		mv88e6xxx_reg_unlock(chip);
> +
> +	return locked;
> +}
> +
>  int mv88e6xxx_port_set_lock(struct mv88e6xxx_chip *chip, int port,
>  			    bool locked)
>  {
> @@ -1261,10 +1282,13 @@ int mv88e6xxx_port_set_lock(struct mv88e6xxx_chip *chip, int port,
>  	if (err)
>  		return err;
>  
> -	reg &= ~MV88E6XXX_PORT_ASSOC_VECTOR_LOCKED_PORT;
> -	if (locked)
> -		reg |= MV88E6XXX_PORT_ASSOC_VECTOR_LOCKED_PORT;
> -
> +	reg &= MV88E6XXX_PORT_ASSOC_VECTOR_PAV_MASK;
> +	if (locked) {
> +		reg |= MV88E6XXX_PORT_ASSOC_VECTOR_IGNORE_WRONG |
> +			MV88E6XXX_PORT_ASSOC_VECTOR_LOCKED_PORT |
> +			MV88E6XXX_PORT_ASSOC_VECTOR_INT_AGE_OUT |
> +			MV88E6XXX_PORT_ASSOC_VECTOR_HOLD_AT_1;

I'd suggest aligning these macros vertically.

> +	}
>  	return mv88e6xxx_port_write(chip, port, MV88E6XXX_PORT_ASSOC_VECTOR, reg);
>  }
>  
> diff --git a/drivers/net/dsa/mv88e6xxx/port.h b/drivers/net/dsa/mv88e6xxx/port.h
> index e0a705d82019..d377abd6ab17 100644
> --- a/drivers/net/dsa/mv88e6xxx/port.h
> +++ b/drivers/net/dsa/mv88e6xxx/port.h
> @@ -231,6 +231,7 @@
>  #define MV88E6XXX_PORT_ASSOC_VECTOR_LOCKED_PORT		0x2000
>  #define MV88E6XXX_PORT_ASSOC_VECTOR_IGNORE_WRONG	0x1000
>  #define MV88E6XXX_PORT_ASSOC_VECTOR_REFRESH_LOCKED	0x0800
> +#define MV88E6XXX_PORT_ASSOC_VECTOR_PAV_MASK		0x07ff
>  
>  /* Offset 0x0C: Port ATU Control */
>  #define MV88E6XXX_PORT_ATU_CTL		0x0c
> @@ -374,6 +375,7 @@ int mv88e6xxx_port_set_fid(struct mv88e6xxx_chip *chip, int port, u16 fid);
>  int mv88e6xxx_port_get_pvid(struct mv88e6xxx_chip *chip, int port, u16 *pvid);
>  int mv88e6xxx_port_set_pvid(struct mv88e6xxx_chip *chip, int port, u16 pvid);
>  
> +bool mv88e6xxx_port_is_locked(struct mv88e6xxx_chip *chip, int port, bool chiplock);
>  int mv88e6xxx_port_set_lock(struct mv88e6xxx_chip *chip, int port,
>  			    bool locked);
>  
> -- 
> 2.30.2
> 
