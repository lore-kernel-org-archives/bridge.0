Return-Path: <roopa@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=OWg+aaQ9WmN2Xf10xAVjfTAf+HVTe/lOP2pxOC7c57Y=;
	b=IR/Wum+UZDxHk5SLB8V+TDEtw+K+AsrfeNWFMl06jBsiKZVta1x2k4mUru0Hm4nQ1X
	VkBk7Y4Dn0Etp9fRQvWDAZdVOBpsfOOsJEdUaUxz1RVvRWPREzjhKZYKrOj/a2atS/xw
	JpnnRh8mUzqvjsm/IBLOWyFEcEc1w7aiSftC8=
MIME-Version: 1.0
In-Reply-To: <1508433452-23812-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1508433452-23812-1-git-send-email-nikolay@cumulusnetworks.com>
From: Roopa Prabhu <roopa@cumulusnetworks.com>
Date: Thu, 19 Oct 2017 15:22:19 -0700
Message-ID: <CAJieiUiM2FWA+7LomQTQjjCruFesoJo=cd2yGVg4s0XzGbxfHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH net] net: bridge: fix returning of vlan range
	op errors
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org

On Thu, Oct 19, 2017 at 10:17 AM, Nikolay Aleksandrov
<nikolay@cumulusnetworks.com> wrote:
> When vlan tunnels were introduced, vlan range errors got silently
> dropped and instead 0 was returned always. Restore the previous
> behaviour and return errors to user-space.
>
> Fixes: efa5356b0d97 ("bridge: per vlan dst_metadata netlink support")
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> ---

Acked-by: Roopa Prabhu <roopa@cumulusnetworks.com>

thanks
