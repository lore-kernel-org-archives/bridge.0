Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B7D8860797
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9954D60784
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sNp7lxVoHrm2s1uAOfiWgASd+t4Thnsz5ago2CYC9k=;
 b=HZQGGUX5TI4Y5inNjJKludRfjdSYpooaaL4td6lQuGDml3gkxzP9a33yMKpT1wKxdkg23YfDi0LjAqF4F4diLm0pyki8yWqxlCbPFQOj+S/4W6fdQxAMynYAG+UeuyVPqJqdWCuqmZHMwl3gp2xZ2+DxanU6KoUuRPzkdcXYGexhl1NYJTbRd/809yXTfwg7ctxb7vw/t/1KrrZGIN2/TiQHQH4snYP3izoEoRjde/rA9gWmPprULRZEFQAbq62nSxPDxD9tv3ofuSbwH/5++8OWnEET3zBUA+kzB4SLsW3KIRtlOsAekWOclFZ19ZGbKsayLY97om2Uoa0rvDBS6w==
Date: Thu, 3 Nov 2022 11:09:30 +0200
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y2OFSq7AZRARG9ov@shredder>
References: <20221018120420.561846-1-idosch@nvidia.com>
 <20221018120420.561846-18-idosch@nvidia.com>
 <e3a74c46-0542-4f21-4975-5bd22bb62ab9@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3a74c46-0542-4f21-4975-5bd22bb62ab9@blackwall.org>
MIME-Version: 1.0
Subject: Re: [Bridge] [RFC PATCH net-next 17/19] bridge: mcast: Allow user
 space to add (*, G) with a source list and filter mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, edumazet@google.com, mlxsw@nvidia.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On Wed, Oct 19, 2022 at 04:28:23PM +0300, Nikolay Aleksandrov wrote:
> On 18/10/2022 15:04, Ido Schimmel wrote:
> > +static int br_mdb_config_src_list_init(struct nlattr *src_list,
> > +				       struct br_mdb_config *cfg,
> > +				       struct netlink_ext_ack *extack)
> > +{
> > +	struct br_mdb_src_entry *src, *tmp;
> > +	struct nlattr *src_entry;
> > +	int rem, err;
> > +
> > +	nla_for_each_nested(src_entry, src_list, rem) {
> > +		err = br_mdb_config_src_entry_init(src_entry, cfg, extack);
> 
> Hmm, since we know the exact number of these (due to attr embedding) can't we allocate
> all at once and drop the list? They should not be more than 32 (PG_SRC_ENT_LIMIT) IIRC,
> which makes it at most 1152 bytes. Might simplify the code a bit and reduce allocations.

I didn't see how I can reliably determine the exact number of source
entries without going all the 'MDBE_SRC_LIST_ENTRY' attributes. I mean,
the entries can have varying sizes in case user space provided mixed
IPv4/IPv6 sources (which will be rejected later on) and in the future we
might have more attributes per-source entry other than the address
(e.g., source timer), which might be specified only for a subset of the
entries.

So, I did end up converting to an array like you suggested, but I'm
going over the entries twice. Once to understand how large the array
should be and again to initialize it. It's control path so it should be
fine. The advantages are that the number of allocations are reduced and
that I can reject a too long source list before doing any processing:

if (cfg->num_src_entries >= PG_SRC_ENT_LIMIT) {
	NL_SET_ERR_MSG_FMT_MOD(extack, "Exceeded maximum number of source entries (%u)",
			       PG_SRC_ENT_LIMIT);
	return -EINVAL;
}

[...]

> > +static void br_mdb_config_fini(struct br_mdb_config *cfg)
> > +{
> > +	br_mdb_config_attrs_fini(cfg);
> > +}
> > +
> 
> Is there more coming to these two _fini helpers? If not, I think one would be enough, i.e.
> just call br_mdb_config_src_list_fini() from br_mdb_config_fini()

Done.

Thanks!
