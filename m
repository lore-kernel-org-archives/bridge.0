Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 274C440423
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C4BD640360
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4I1ZeFsKAt18pfXWOdiAh+rpp3hzVgdiHuWjwOHawr4=;
 b=dFhWlbiH6jzdNHd2kJMyqT0cA0ZWfO6AZ1idHY4q28/AYW8w3YORh3mXJB+04AwSHhiNcEnYwVjtiUh8D90jCi+++QTibR+z+43rMWI5O0WjvXuY6ZqhZyAai/RTOaZWJ8umroGmIzQPjgEjXhe3rpylOIc08iT9o382RAaSQIda/3/OVrU3jOgaXSJkJmccJIHtoPk5H7GpeX2M6azLZt73CadqTm+MBtMwnKO4+mpDV+l6JPlzdjkl3nZFUL9OFUy+GxoqjfA6nSnaCvN/4pScb11q+GhinWbNLDn+vI2mgClbXg9204LwYuEr/A1TSpW0OByGKGneV2U32aFYDg==
Date: Sat, 11 Feb 2023 17:45:57 +0200
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y+e4NTGi7VASbm5K@shredder>
References: <20230209071852.613102-1-idosch@nvidia.com>
 <20230209071852.613102-4-idosch@nvidia.com>
 <20230210192057.4927b002@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210192057.4927b002@kernel.org>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 3/4] bridge: mcast: Move validation to
	a policy
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>
Cc: petrm@nvidia.com, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, edumazet@google.com, mlxsw@nvidia.com, roopa@nvidia.com, pabeni@redhat.com, davem@davemloft.net

On Fri, Feb 10, 2023 at 07:20:57PM -0800, Jakub Kicinski wrote:
> On Thu,  9 Feb 2023 09:18:51 +0200 Ido Schimmel wrote:
> > +	if (nla_len(attr) != sizeof(struct br_mdb_entry)) {
> > +		NL_SET_ERR_MSG_MOD(extack, "Invalid MDBA_SET_ENTRY attribute length");
> > +		return -EINVAL;
> 
> Well, you're just moving it, but NL_SET_ERR_MSG_ATTR() would be better.
> We shouldn't be adding _MOD() in the core implementation of the family.

Assuming you are referring to this code when it's moved to
net/core/rtnetlink.c, then I already removed the _MOD() suffix from it
(as visible in the RFC). I can squash this as well:

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index c9f878a28d32..491e4231b3dd 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -6138,7 +6138,7 @@ static int rtnl_validate_mdb_entry(const struct nlattr *attr,
        struct br_mdb_entry *entry = nla_data(attr);
 
        if (nla_len(attr) != sizeof(struct br_mdb_entry)) {
-               NL_SET_ERR_MSG(extack, "Invalid MDBA_SET_ENTRY attribute length");
+               NL_SET_ERR_MSG_ATTR(extack, attr, "Invalid attribute length");
                return -EINVAL;
        }
