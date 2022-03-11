Return-Path: <schultz.hans@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=Mwdiioncj/l/cynziYaX1F6ed/Qr7hUrnVD41vK//OY=;
 b=NFol+J8jV+aPmMHdQfby2hgu/UECHYPTMby4XDMqFm2Dx3W0K15oIN3u/7h3B8HlAM
 XVYWOg7KIdNTdnce9miayjD42y6zEOCsjpzqcIHHJrAGvly+9o53fXqUJqm7etjTsB4i
 GkVsWujIJ5enwoNBRmgMg1gMFwpudEaRfea89eNVXAdpCd3ynMiJOGjTqwHDwRIu+LBX
 SCMJqY2RZ/Fo0G2w+8y/syFGrrrT8HtFXvGLoXAt/LEFXUklTKwX7FOfCZ5lAxIcyQwR
 X8kKP/ZC3tvWkem1uWTlzEg/HgrneNlPoQsC8EcFAwfEfngnV5IUBUlizXleOITgPxB3
 2F3w==
From: Hans Schultz <schultz.hans@gmail.com>
In-Reply-To: <YioRQpUTJ7WmTLXQ@lunn.ch>
References: <20220310142320.611738-1-schultz.hans+netdev@gmail.com>
 <20220310142320.611738-4-schultz.hans+netdev@gmail.com>
 <YioRQpUTJ7WmTLXQ@lunn.ch>
Date: Fri, 11 Mar 2022 08:59:04 +0100
Message-ID: <86y21gvs1j.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next 3/3] net: dsa: mv88e6xxx: mac-auth/MAB
 implementation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>, Hans Schultz <schultz.hans@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On tor, mar 10, 2022 at 15:54, Andrew Lunn <andrew@lunn.ch> wrote:
>> +		if (mv88e6xxx_port_is_locked(chip, chip->ports[spid].port))
>> +			err = mv88e6xxx_switchdev_handle_atu_miss_violation(chip,
>> +									    chip->ports[spid].port,
>> +									    &entry,
>> +									    fid);
>
>> +static int mv88e6xxx_find_vid_on_matching_fid(struct mv88e6xxx_chip *chip,
>> +					      const struct mv88e6xxx_vtu_entry *entry,
>> +					      void *priv)
>> +{
>> +	struct mv88e6xxx_fid_search_ctx *ctx = priv;
>> +
>> +	if (ctx->fid_search == entry->fid) {
>> +		ctx->vid_found = entry->vid;
>> +		return 1;
>> +	}
>> +	return 0;
>> +}
>> +
>> +int mv88e6xxx_switchdev_handle_atu_miss_violation(struct mv88e6xxx_chip *chip,
>> +						  int port,
>> +						  struct mv88e6xxx_atu_entry *entry,
>> +						  u16 fid)
>> +{
>> +	struct switchdev_notifier_fdb_info info = {
>> +		.addr = entry->mac,
>> +		.vid = 0,
>> +		.added_by_user = false,
>> +		.is_local = false,
>> +		.offloaded = true,
>> +		.locked = true,
>> +	};
>> +	struct mv88e6xxx_fid_search_ctx ctx;
>> +	struct netlink_ext_ack *extack;
>> +	struct net_device *brport;
>> +	struct dsa_port *dp;
>> +	int err;
>> +
>> +	ctx.fid_search = fid;
>> +	err = mv88e6xxx_vtu_walk(chip, mv88e6xxx_find_vid_on_matching_fid, &ctx);
>
> I could be reading this code wrong, but it looks like you assume there
> is a single new entry in the ATU. But interrupts on these devices are
> slow. It would be easy for two or more devices to pop into existence
> at the same time. Don't you need to walk the whole ATU to find all the
> new entries? Have you tried this with a traffic generating populating
> the ATU with new entries at different rates, up to line rate? Do you
> get notifications for them all?
>
>     Andrew

We have not tried your said test, but if a packet doesn't manage to
trigger a ATU miss violation interrupt, not much will happen as far as I
see. The device sending the packet will not get access, but if it sends
again (maybe after a short while), it can still trigger the ATU miss
violation interrupt and get access.
I think that the normal behaviour for a device would be to try and
connect, and if that is not successfull inside a short time, it will wait
for a timeout before trying again.
