Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=Urg3WNbWAAbmT/1unZ8S+i2ajaf9UWWtyCFD6wiRjuI=;
 b=ibyW2IIHcc8wVZkOHS/s3WSv0MoDzWtmuPnwfhxKEi4RzBk+lE+OjaZj1DhEPuw3Hy
 6NJ+CVirQCZZcErNoU0TAeox7TvSA/CXrx4gFqLwyEAmtLusg2Gr1PN5ur2YAPvxGmMx
 l1llRE5cg55Kho7+i0Suwu/IgcZ5k6U+blXsx/wc1j5CokN/Ry6tC01zoSbllzYJNACg
 XPkLEi65esJc8k4lnuPC40ZEp1Od8Y5LSzhcmhOtqZMMvnDrZTcodeFp2SWWjdlOUNsK
 8FLIvFyFV/lB5HpY7PItzvZJ8xADMKRWwUY9xYisLDX7x052HHECkMO+7GDDEzpz1jbu
 7syw==
Message-ID: <a869797f-8501-3766-36ae-b73b76e8f7e7@blackwall.org>
Date: Mon, 11 Apr 2022 12:07:14 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20220409105857.803667-1-razor@blackwall.org>
 <20220409105857.803667-5-razor@blackwall.org> <YlPrJaWjeObhxmwb@shredder>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <YlPrJaWjeObhxmwb@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 4/6] net: bridge: fdb: add support for
 flush filtering based on ndm flags and state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com

On 11/04/2022 11:47, Ido Schimmel wrote:
> On Sat, Apr 09, 2022 at 01:58:55PM +0300, Nikolay Aleksandrov wrote:
>> Add support for fdb flush filtering based on ndm flags and state. The
>> new attributes allow users to specify a mask and value which are mapped
>> to bridge-specific flags. NTF_USE is used to represent added_by_user
>> flag since it sets it on fdb add and we don't have a 1:1 mapping for it.
>>
>> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
>> ---
>>  include/uapi/linux/if_bridge.h |  4 +++
>>  net/bridge/br_fdb.c            | 55 ++++++++++++++++++++++++++++++++++
>>  2 files changed, 59 insertions(+)
>>
>> diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
>> index 2f3799cf14b2..4638d7e39f2a 100644
>> --- a/include/uapi/linux/if_bridge.h
>> +++ b/include/uapi/linux/if_bridge.h
>> @@ -815,6 +815,10 @@ enum {
>>  /* embedded in BRIDGE_FLUSH_FDB */
>>  enum {
>>  	FDB_FLUSH_UNSPEC,
>> +	FDB_FLUSH_NDM_STATE,
>> +	FDB_FLUSH_NDM_STATE_MASK,
>> +	FDB_FLUSH_NDM_FLAGS,
>> +	FDB_FLUSH_NDM_FLAGS_MASK,
>>  	__FDB_FLUSH_MAX
>>  };
>>  #define FDB_FLUSH_MAX (__FDB_FLUSH_MAX - 1)
>> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
>> index 62f694a739e1..340a2ace1d5e 100644
>> --- a/net/bridge/br_fdb.c
>> +++ b/net/bridge/br_fdb.c
>> @@ -594,8 +594,40 @@ void br_fdb_flush(struct net_bridge *br,
>>  	rcu_read_unlock();
>>  }
>>  
>> +static unsigned long __ndm_state_to_fdb_flags(u16 ndm_state)
>> +{
>> +	unsigned long flags = 0;
>> +
>> +	if (ndm_state & NUD_PERMANENT)
>> +		__set_bit(BR_FDB_LOCAL, &flags);
>> +	if (ndm_state & NUD_NOARP)
>> +		__set_bit(BR_FDB_STATIC, &flags);
>> +
>> +	return flags;
>> +}
>> +
>> +static unsigned long __ndm_flags_to_fdb_flags(u16 ndm_flags)
>> +{
>> +	unsigned long flags = 0;
>> +
>> +	if (ndm_flags & NTF_USE)
>> +		__set_bit(BR_FDB_ADDED_BY_USER, &flags);
>> +	if (ndm_flags & NTF_EXT_LEARNED)
>> +		__set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &flags);
>> +	if (ndm_flags & NTF_OFFLOADED)
>> +		__set_bit(BR_FDB_OFFLOADED, &flags);
>> +	if (ndm_flags & NTF_STICKY)
>> +		__set_bit(BR_FDB_STICKY, &flags);
>> +
>> +	return flags;
>> +}
>> +
>>  static const struct nla_policy br_fdb_flush_policy[FDB_FLUSH_MAX + 1] = {
>>  	[FDB_FLUSH_UNSPEC]	= { .type = NLA_REJECT },
>> +	[FDB_FLUSH_NDM_STATE]	= { .type = NLA_U16 },
>> +	[FDB_FLUSH_NDM_FLAGS]	= { .type = NLA_U16 },
>> +	[FDB_FLUSH_NDM_STATE_MASK]	= { .type = NLA_U16 },
>> +	[FDB_FLUSH_NDM_FLAGS_MASK]	= { .type = NLA_U16 },
> 
> Might be better to use NLA_POLICY_MASK(NLA_U16, mask) and reject
> unsupported states / flags instead of just ignoring them?
> 

Yep, forgot about that one. Good point!


