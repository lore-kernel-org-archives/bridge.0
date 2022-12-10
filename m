Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E0CC84090F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D23C7408C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuCMPih4pfutIhIHC0yYlTVOYFxEPhnD0DIBx8tym7M=;
 b=mNkpkNP1AWlGeXSDY82hBN2wkR4a6TDS6O5B1KeOxC7cvvcA0VnUOzo4IF0pfmpix3ea3MOxUqSMA3QdGGQTJL47PKD8TyJULNUQbnofAO7G1Q3uK9KAL2sPuwBnnbwcumMV7wPZk19X3Z5m9kjd6RNmc5pGVV+7dwzXjlYYrIFYQ/jdsLeSLlIgOF4ONxl27ieaD5fMHjixxyF0/x1NKj63AWJdHXfH7ZIFyhU96480Xz0htriw6jzY5Oc/Ey/dYCv/4z4cyg/yidmazK1eErm81zMA1Ah43EZpr9prtlcCZ40UnSZhZPuy/YaqtPYjafGl0iPyZPBI5njF56SY8A==
Date: Sat, 10 Dec 2022 15:33:09 +0200
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y5SKlVl6cuSp1Ib1@shredder>
References: <20221208152839.1016350-1-idosch@nvidia.com>
 <20221208152839.1016350-10-idosch@nvidia.com>
 <22583106-8f39-0c7e-1c61-47ec5c614418@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22583106-8f39-0c7e-1c61-47ec5c614418@blackwall.org>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 09/14] bridge: mcast: Add support for
 (*, G) with a source list and filter mode
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

On Fri, Dec 09, 2022 at 09:41:05AM +0200, Nikolay Aleksandrov wrote:
> On 08/12/2022 17:28, Ido Schimmel wrote:
> > In preparation for allowing user space to add (*, G) entries with a
> > source list and associated filter mode, add the necessary plumbing to
> > handle such requests.
> > 
> > Extend the MDB configuration structure with a currently empty source
> > array and filter mode that is currently hard coded to EXCLUDE.
> > 
> > Add the source entries and the corresponding (S, G) entries before
> > making the new (*, G) port group entry visible to the data path.
> > 
> > Handle the creation of each source entry in a similar fashion to how it
> > is created from the data path in response to received Membership
> > Reports: Create the source entry, arm the source timer (if needed), add
> > a corresponding (S, G) forwarding entry and finally mark the source
> > entry as installed (by user space).
> > 
> > Add the (S, G) entry by populating an MDB configuration structure and
> > calling br_mdb_add_group_sg() as if a new entry is created by user
> > space, with the sole difference that the 'src_entry' field is set to
> > make sure that the group timer of such entries is never armed.
> > 
> > Note that it is not currently possible to add more than 32 source
> > entries to a port group entry. If this proves to be a problem we can
> > either increase 'PG_SRC_ENT_LIMIT' or avoid forcing a limit on entries
> > created by user space.
> > 
> 
> That can be tricky wrt EHT. If the limit is increased we have to consider the
> complexity and runtime, we might have to optimize it. In practice I think it's
> rare to have so many sources, but evpn might change that. :)

Yea, we don't currently have data as to whether this limit is OK or not.
Once we do we can make a more informed decision. Some options:

1. Slightly increase the current limit.
2. Remove the limit and move to an RB tree instead of a list.
3. Only install (*, G) EXCLUDE entries on the VXLAN port and let the
VXLAN MDB do more fine-grained filtering.

> 
> > Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> > ---
> > 
> > Notes:
> >     v1:
> >     * Use an array instead of a list to store source entries.
> > 
> >  net/bridge/br_mdb.c     | 128 +++++++++++++++++++++++++++++++++++++++-
> >  net/bridge/br_private.h |   7 +++
> >  2 files changed, 132 insertions(+), 3 deletions(-)
> > 
> 
> Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

Thanks!
