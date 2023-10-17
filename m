Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3CA79403C9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 915D1402A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmLdHhpXrFuKOvT1IcIni34J/fCWB9xKWA93NHpp+dI=;
 b=fTeTwMLPxex7X1dpVWnHV73m4UhdaeSXVaYJ8nQJgsBGigXAP5pcp01ktifXsTPmceimVZjJiCIucMlrur/MTQU8NQmp3rK3JoMYbhE2FyAdxBV2XZG77OT6NXt5COWqvHV0BouT5EitnD909lsf76VmgozoyfGiw8C+ak+bOV6txI911QxWzuuc4lZbMPUml1ENHoEQiXYzU+5a1o6cTDuOhpaXuCwFySb7aQtvkJnmPYRFwtG1JYrLPpIKD3ocUYCpmxcxnW6hCObBjUC0dw2YK0w2Lf7A93HTjWi6huCr7igMSoi3L9shNsbW2hSpDAbJ/swSDv/zJdE9wKUjkg==
Date: Tue, 17 Oct 2023 13:58:39 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <ZS5o337prUOKspUL@shredder>
References: <20231016131259.3302298-1-idosch@nvidia.com>
 <20231016131259.3302298-8-idosch@nvidia.com>
 <b3e0d656-cb25-3ac8-6391-8fb27217470b@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3e0d656-cb25-3ac8-6391-8fb27217470b@blackwall.org>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 07/13] bridge: add MDB get uAPI
	attributes
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

On Tue, Oct 17, 2023 at 12:08:30PM +0300, Nikolay Aleksandrov wrote:
> On 10/16/23 16:12, Ido Schimmel wrote:
> > Add MDB get attributes that correspond to the MDB set attributes used in
> > RTM_NEWMDB messages. Specifically, add 'MDBA_GET_ENTRY' which will hold
> > a 'struct br_mdb_entry' and 'MDBA_GET_ENTRY_ATTRS' which will hold
> > 'MDBE_ATTR_*' attributes that are used as indexes (source IP and source
> > VNI).
> > 
> > An example request will look as follows:
> > 
> > [ struct nlmsghdr ]
> > [ struct br_port_msg ]
> > [ MDBA_GET_ENTRY ]
> > 	struct br_mdb_entry
> > [ MDBA_GET_ENTRY_ATTRS ]
> > 	[ MDBE_ATTR_SOURCE ]
> > 		struct in_addr / struct in6_addr
> > 	[ MDBE_ATTR_SRC_VNI ]
> > 		u32
> > 
> 
> Could you please add this info as a comment above the enum?
> Similar to the enum below it. It'd be nice to have an example
> of what's expected.

Yes, will add in v2

Thanks
