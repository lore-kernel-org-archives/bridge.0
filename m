Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-me-sender
	:x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=vF+M2DtGBa4JCIeSkp
	xJDHQMfQLKJp7uO48quCuo3fU=; b=CEgKb/alCVMOZwuOY4cHZRVNd0HM+gFUML
	esyiKVpa+ioz4GDrtWDcVAnrQdSXePYXw2O/U0N/laaZitollxFSyflWYfpfdBXC
	Gltdp2IbC0FYOlFwaJQ4R6IZk2o0dbY8AYEEfo+sgSdpN82D++Unn55dyVMBJN8b
	nRt/VffFP09EpeP3IqSE/40/GhXyCZEMVNasjIqsVjZxWxl9eHSXq5itipk3a2UZ
	+mdcqcTKdRKWHhHUWj0mOCpXKIRyDkWrVYSvVkC1Hlc/K0BiBF9abyldEH/Eb37H
	S57gN2RUc8cbDu/xG3QZrEWFMmQBZi3Gr3df/5imU3El21IxjQvw==
Date: Thu, 23 Mar 2017 21:47:13 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <20170323194713.GA25688@splinter.mtl.com>
References: <1490264833-28867-1-git-send-email-nikolay@cumulusnetworks.com>
	<1490264833-28867-2-git-send-email-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490264833-28867-2-git-send-email-nikolay@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH net-next 1/2] net: bridge: allow SW learn to
 take over HW fdb entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: jiri@resnulli.us, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, idosch@mellanox.com, davem@davemloft.net

On Thu, Mar 23, 2017 at 12:27:12PM +0200, Nikolay Aleksandrov wrote:
> Allow to take over an entry which was previously learned via HW when it
> shows up from a SW port. This is analogous to how HW takes over SW learned
> entries already.
> 
> Suggested-by: Roopa Prabhu <roopa@cumulusnetworks.com>
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
