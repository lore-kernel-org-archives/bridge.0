Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=a47/kfMIXmMimdkS0oL0JoxaVtTsUq4puZeDbeGUm9Y=;
 b=04IWU311iyNWvLh+4z6efV3IVimCg+0iXV/HO6uNNlDwrOjW8ZhyHR4SuudlVDuTum
 gqZVmZReaIp6IBpYdIONB8k97GEYu3RMgnjWcytVYtlZC+m5/D3tZZOk9RtPgWsgRTX9
 5S0ShUCrhTY36HShqYZB/KcEFIsfQcgRXYYrDkyXF+P7qHqVkEiTgiaw/eqJcRLMaxLz
 oYgakxqRrR/MCiS3Zt8tB2qNRm7bUSX94KJjWKWXyDSYUkgbhRDJp4aMpxmIiUWlH9n5
 ZtSV23o6uIaELOrquC+AVpftGUgiYGUIKp4YM4X6sEZVQ/gBkfUqwR+wNuQNrKL6gYrz
 JKVQ==
From: Tobias Waldekranz <tobias@waldekranz.com>
In-Reply-To: <20220310103509.g35syl776kyh5j2n@skbuf>
References: <20220301100321.951175-1-tobias@waldekranz.com>
 <20220301100321.951175-8-tobias@waldekranz.com>
 <20220303222055.7a5pr4la3wmuuekc@skbuf> <87mthymblh.fsf@waldekranz.com>
 <20220310103509.g35syl776kyh5j2n@skbuf>
Date: Thu, 10 Mar 2022 17:05:35 +0100
Message-ID: <87h785n67k.fsf@waldekranz.com>
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

On Thu, Mar 10, 2022 at 12:35, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Thu, Mar 10, 2022 at 09:54:34AM +0100, Tobias Waldekranz wrote:
>> >> +	if (!dsa_port_can_configure_learning(dp) || dp->learning) {
>> >> +		switch (state->state) {
>> >> +		case BR_STATE_DISABLED:
>> >> +		case BR_STATE_BLOCKING:
>> >> +		case BR_STATE_LISTENING:
>> >> +			/* Ideally we would only fast age entries
>> >> +			 * belonging to VLANs controlled by this
>> >> +			 * MST.
>> >> +			 */
>> >> +			dsa_port_fast_age(dp);
>> >
>> > Does mv88e6xxx support this? If it does, you might just as well
>> > introduce another variant of ds->ops->port_fast_age() for an msti.
>> 
>> You can limit ATU operations to a particular FID. So the way I see it we
>> could either have:
>> 
>> int (*port_vlan_fast_age)(struct dsa_switch *ds, int port, u16 vid)
>> 
>> + Maybe more generic. You could imagine there being a way to trigger
>>   this operation from userspace for example.
>> - We would have to keep the VLAN<->MSTI mapping in the DSA layer in
>>   order to be able to do the fan-out in dsa_port_set_mst_state.
>> 
>> or:
>> 
>> int (*port_msti_fast_age)(struct dsa_switch *ds, int port, u16 msti)
>> 
>> + Let's the mapping be an internal affair in the driver.
>> - Perhaps, less generically useful.
>> 
>> Which one do you prefer? Or is there a hidden third option? :)
>
> Yes, I was thinking of "port_msti_fast_age". I don't see a cheap way of
> keeping VLAN to MSTI associations in the DSA layer. Only if we could
> retrieve this mapping from the bridge layer - maybe with something
> analogous to br_vlan_get_info(), but br_mst_get_info(), and this gets
> passed a VLAN_N_VID sized bitmap, which the bridge populates with ones
> and zeroes.

That can easily be done. Given that, should we go for port_vlan_fast_age
instead? port_msti_fast_age feels like an awkward interface, since I
don't think there is any hardware out there that can actually perform
that operation without internally fanning it out over all affected VIDs
(or FIDs in the case of mv88e6xxx).

> The reason why I asked for this is because I'm not sure of the
> implications of flushing the entire FDB of the port for a single MSTP
> state change. It would trigger temporary useless flooding in other MSTIs
> at the very least. There isn't any backwards compatibility concern to
> speak of, so we can at least try from the beginning to limit the
> flushing to the required VLANs.

Aside from the performance implications of flows being temporarily
flooded I don't think there are any.

I suppose if you've disabled flooding of unknown unicast on that port,
you would loose the flow until you see some return traffic (or when one
side gives up and ARPs). While somewhat esoteric, it would be nice to
handle this case if the hardware supports it.

> What I didn't think about, and will be a problem, is
> dsa_port_notify_bridge_fdb_flush() - we don't know the vid to flush.
> The easy way out here would be to export dsa_port_notify_bridge_fdb_flush(),
> add a "vid" argument to it, and let drivers call it. Thoughts?

To me, this seems to be another argument in favor of
port_vlan_fast_age. That way you would know the VIDs being flushed at
the DSA layer, and driver writers needn't concern themselves with having
to remember to generate the proper notifications back to the bridge.

> Alternatively, if you think that cross-flushing FDBs of multiple MSTIs
> isn't a real problem, I suppose we could keep the "port_fast_age" method.

What about falling back to it if the driver doesn't support per-VLAN
flushing? Flushing all entries will work in most cases, at the cost of
some temporary flooding. Seems more useful than refusing the offload
completely.

>> > And since it is new code, you could require that drivers _do_ support
>> > configuring learning before they could support MSTP. After all, we don't
>> > want to keep legacy mechanisms in place forever.
>> 
>> By "configuring learning", do you mean this new fast-age-per-vid/msti,
>> or being able to enable/disable learning per port? If it's the latter,
>> I'm not sure I understand how those two are related.
>
> The code from dsa_port_set_state() which you've copied:
>
> 	if (!dsa_port_can_configure_learning(dp) ||
> 	    (do_fast_age && dp->learning)) {
>
> has this explanation:
>
> 1. DSA keeps standalone ports in the FORWARDING state.
> 2. DSA also disables address learning on standalone ports, where this is
>    possible (dsa_port_can_configure_learning(dp) == true).
> 3. When a port joins a bridge, it leaves its FORWARDING state from
>    standalone mode and inherits the bridge port's BLOCKING state
> 4. dsa_port_set_state() treats a port transition from FORWARDING to
>    BLOCKING as a transition requiring an FDB flush
> 5. due to (2), the FDB flush at stage (4) is in fact not needed, because
>    the FDB of that port should already be empty. Flushing the FDB may be
>    a costly operation for some drivers, so it is avoided if possible.
>
> So this is why the "dsa_port_can_configure_learning()" check is there -
> for compatibility with drivers that can't configure learning => they
> keep learning enabled also in standalone mode => they need an FDB flush
> when a standalone port joins a bridge.
>
> What I'm saying is: for drivers that offload MSTP, let's force them to
> get the basics right first (have configurable learning), rather than go
> forward forever with a backwards compatibility mode.

Makes sense, I'll just move it up to the initial capability check.
