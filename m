Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-type:content-transfer-encoding;
	bh=Om+QcxwR8tWYpwOURTBnYAuAyx+WP0IEyJ+iWJQFYvM=;
	b=FaG7aPPB/HOvzanZD1NFAHrIt48USZbgY7Fxf2DatCOfrQOctHHk8sGNuEMrl5yvQm
	LUTMQfesCRDkf9R8/cLL10IxT5477aEQxwnPHiX+2kO0O+d3tyTTGJn2vINj3TCA+5MU
	5wfLiszq/0D3S7N8z6xjoX2E2VF4eNH7mcURA=
References: <1444147589-11153-1-git-send-email-roopa@cumulusnetworks.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <56150495.2070909@cumulusnetworks.com>
Date: Wed, 7 Oct 2015 13:40:05 +0200
MIME-Version: 1.0
In-Reply-To: <1444147589-11153-1-git-send-email-roopa@cumulusnetworks.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2] bridge: allow adding of fdb
 entries pointing to the bridge device
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@cumulusnetworks.com>, davem@davemloft.net, netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org

On 10/06/2015 06:06 PM, Roopa Prabhu wrote:
> From: Roopa Prabhu <roopa@cumulusnetworks.com>
> 
> This patch enables adding of fdb entries pointing to the bridge device.
> This can be used to propagate mac address of vlan interfaces
> configured on top of the vlan filtering bridge.
> 
> Before:
> $bridge fdb add 44:38:39:00:27:9f dev bridge
> RTNETLINK answers: Invalid argument
> 
> After:
> $bridge fdb add 44:38:39:00:27:9f dev bridge
> 
> Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>
> Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> ---
>  net/bridge/br_fdb.c | 110 ++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 85 insertions(+), 25 deletions(-)
> 

Ugh my bad, Dave please don't apply this version, there're still a few rough
edges we need to take care of. Now that bridge's vlan_group can be used in these
functions the vlans should be checked for context-only, i.e. br_vlan_should_use()
and also when a port vlan is deleted its fdb entries are flushed, but that is not
done for the bridge since it wasn't possible to add them like this. So v3 coming
soon to your neighborhood! :-)

Thanks,
 Nik


