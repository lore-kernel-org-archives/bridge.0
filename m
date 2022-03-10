Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=CckdNSYPYZf2rZDScH/OvPXL2AjJadCF3mmLi4f4hcw=;
 b=OatCttRymAWh3ZREbboDujJz9m9mKb6j9QdM/3v3pS2K7KTkLFG+k8cG9fBTZNcjdW
 gtGT+tN3NJ6VW/p4KfmHQJkDdLVYos5GzYyJ/9unQlgQ7cESvTm1HxBCfo1UCONKsdMm
 fwJvsu20JYy4EgZ9iXhjGJXCxJUgGl7DqkzGCH1068ATWlthRii7cMKewPdC+RWmp7Ec
 Vk/08waJ10OZFdJJHx4hWZ2HEwobcM6uqlSOgmO8XDYCIS1m7CAnRuzZ+NsP0cR65E15
 9rVUj82I+XRk4+qVe34UIhzmH1TyfDWLDb03haGYYvuwK7SAE6u4k976t+9z36hGu1x/
 4Img==
From: Tobias Waldekranz <tobias@waldekranz.com>
In-Reply-To: <20220303222055.7a5pr4la3wmuuekc@skbuf>
References: <20220301100321.951175-1-tobias@waldekranz.com>
 <20220301100321.951175-8-tobias@waldekranz.com>
 <20220303222055.7a5pr4la3wmuuekc@skbuf>
Date: Thu, 10 Mar 2022 09:54:34 +0100
Message-ID: <87mthymblh.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH v2 net-next 07/10] net: dsa: Pass MST state
 changes to driver
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Matt Johnston <matt@codeconstruct.com.au>, davem@davemloft.net, linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 00:20, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Tue, Mar 01, 2022 at 11:03:18AM +0100, Tobias Waldekranz wrote:
>> Add the usual trampoline functionality from the generic DSA layer down
>> to the drivers for MST state changes.
>> 
>> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>> ---
>>  include/net/dsa.h  |  2 ++
>>  net/dsa/dsa_priv.h |  2 ++
>>  net/dsa/port.c     | 30 ++++++++++++++++++++++++++++++
>>  net/dsa/slave.c    |  6 ++++++
>>  4 files changed, 40 insertions(+)
>> 
>> diff --git a/include/net/dsa.h b/include/net/dsa.h
>> index cc8acb01bd9b..096e6e3a8e1e 100644
>> --- a/include/net/dsa.h
>> +++ b/include/net/dsa.h
>> @@ -943,6 +943,8 @@ struct dsa_switch_ops {
>>  				     struct dsa_bridge bridge);
>>  	void	(*port_stp_state_set)(struct dsa_switch *ds, int port,
>>  				      u8 state);
>> +	int	(*port_mst_state_set)(struct dsa_switch *ds, int port,
>> +				      const struct switchdev_mst_state *state);
>>  	void	(*port_fast_age)(struct dsa_switch *ds, int port);
>>  	int	(*port_pre_bridge_flags)(struct dsa_switch *ds, int port,
>>  					 struct switchdev_brport_flags flags,
>> diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
>> index 87ec0697e92e..a620e079ebc5 100644
>> --- a/net/dsa/dsa_priv.h
>> +++ b/net/dsa/dsa_priv.h
>> @@ -198,6 +198,8 @@ static inline struct net_device *dsa_master_find_slave(struct net_device *dev,
>>  void dsa_port_set_tag_protocol(struct dsa_port *cpu_dp,
>>  			       const struct dsa_device_ops *tag_ops);
>>  int dsa_port_set_state(struct dsa_port *dp, u8 state, bool do_fast_age);
>> +int dsa_port_set_mst_state(struct dsa_port *dp,
>> +			   const struct switchdev_mst_state *state);
>>  int dsa_port_enable_rt(struct dsa_port *dp, struct phy_device *phy);
>>  int dsa_port_enable(struct dsa_port *dp, struct phy_device *phy);
>>  void dsa_port_disable_rt(struct dsa_port *dp);
>> diff --git a/net/dsa/port.c b/net/dsa/port.c
>> index 5f45cb7d70ba..26cfbc8ab499 100644
>> --- a/net/dsa/port.c
>> +++ b/net/dsa/port.c
>> @@ -108,6 +108,36 @@ int dsa_port_set_state(struct dsa_port *dp, u8 state, bool do_fast_age)
>>  	return 0;
>>  }
>>  
>> +int dsa_port_set_mst_state(struct dsa_port *dp,
>> +			   const struct switchdev_mst_state *state)
>> +{
>> +	struct dsa_switch *ds = dp->ds;
>> +	int err, port = dp->index;
>> +
>> +	if (!ds->ops->port_mst_state_set)
>> +		return -EOPNOTSUPP;
>> +
>> +	err = ds->ops->port_mst_state_set(ds, port, state);
>> +	if (err)
>> +		return err;
>> +
>> +	if (!dsa_port_can_configure_learning(dp) || dp->learning) {
>> +		switch (state->state) {
>> +		case BR_STATE_DISABLED:
>> +		case BR_STATE_BLOCKING:
>> +		case BR_STATE_LISTENING:
>> +			/* Ideally we would only fast age entries
>> +			 * belonging to VLANs controlled by this
>> +			 * MST.
>> +			 */
>> +			dsa_port_fast_age(dp);
>
> Does mv88e6xxx support this? If it does, you might just as well
> introduce another variant of ds->ops->port_fast_age() for an msti.

You can limit ATU operations to a particular FID. So the way I see it we
could either have:

int (*port_vlan_fast_age)(struct dsa_switch *ds, int port, u16 vid)

+ Maybe more generic. You could imagine there being a way to trigger
  this operation from userspace for example.
- We would have to keep the VLAN<->MSTI mapping in the DSA layer in
  order to be able to do the fan-out in dsa_port_set_mst_state.

or:

int (*port_msti_fast_age)(struct dsa_switch *ds, int port, u16 msti)

+ Let's the mapping be an internal affair in the driver.
- Perhaps, less generically useful.

Which one do you prefer? Or is there a hidden third option? :)

> And since it is new code, you could require that drivers _do_ support
> configuring learning before they could support MSTP. After all, we don't
> want to keep legacy mechanisms in place forever.

By "configuring learning", do you mean this new fast-age-per-vid/msti,
or being able to enable/disable learning per port? If it's the latter,
I'm not sure I understand how those two are related.
