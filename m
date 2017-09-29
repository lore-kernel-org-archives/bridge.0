Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=zBinwFq4EhA9qAWe6dQfNQ6VbVgySxH0e8f9cc/4AXc=;
	b=RFYQqPlPRY+vsYy3ogzjShTABsckQBqMACxx24hX4ROK3PvTA4GYXcrcQkQloZ9/Ag
	Q55z++jAdv6yn0TG6iCbgbKlMH0ABHxfdEAWjMEXRqwOcVTOa5DsX981NXl079dxW2Df
	JySKuhnope/F1cLE+7m8skcgIKPYx1AL+Ch0g=
References: <1506517964-17479-1-git-send-email-nikolay@cumulusnetworks.com>
	<20170929081420.3b069170@xeon-e3>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <e9a70870-9b6b-0ec4-de1e-d41da80fd10f@cumulusnetworks.com>
Date: Sat, 30 Sep 2017 00:01:24 +0300
MIME-Version: 1.0
In-Reply-To: <20170929081420.3b069170@xeon-e3>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: add per-port
 group_fwd_mask with less restrictions
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org

On 29/09/17 18:14, Stephen Hemminger wrote:
> On Wed, 27 Sep 2017 16:12:44 +0300
> Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:
> 
>> We need to be able to transparently forward most link-local frames via
>> tunnels (e.g. vxlan, qinq). Currently the bridge's group_fwd_mask has a
>> mask which restricts the forwarding of STP and LACP, but we need to be able
>> to forward these over tunnels and control that forwarding on a per-port
>> basis thus add a new per-port group_fwd_mask option which only disallows
>> mac pause frames to be forwarded (they're always dropped anyway).
>> The patch does not change the current default situation - all of the others
>> are still restricted unless configured for forwarding.
>> We have successfully tested this patch with LACP and STP forwarding over
>> VxLAN and qinq tunnels.
>>
>> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> 
> LACP is fine, but STP must not be forwarded if STP in user or kernel
> mode is enabled.
> 
> Please update this patch or revert it.
> 

The default has not changed, STP is still _not_ forwarded. It can be only if explicitly
requested by the user and that means the port might be participating in STP but not
the bridge's STP, that is explicitly forward all STP frames from that port.
I don't think we have to change anything.

