Return-Path: <tobin@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=P0E+vg
	w7gVRhrh8/UI9GOpgCdpeDnUgHcsc0wsgCABU=; b=hWfK03kaNW7Ohu10St/HLh
	wuLsm4DJNPEP7VHvtse/oH/duT+siM0gUEPsKB9Ls2IzHjTZJntjWyWHbPa5Z4QK
	/1pJF4xj5SymqPMXgnOtbeZWuPZTLfMnC4H3UDb9h+sQSnUJOYM3mlPjVQHifPBH
	6zF1IOWBmGkgCmAxvGSrIRaoSlYLKOYwX52MQ4CUrH+9WtwjQ17Obh8KCIIVQtbc
	K0D0ZjhQZBSRHfcs5wJUftuOsIM4vy2EJf57LJ6MUSJDFdX6uqR9QkFLYb+HdQ4V
	6PgMcGGGpxIGgsFJblZXDJLayynxOGB7pDVxpums+6Jj7d6yDfkIttD8rYz8orqg
	==
Date: Fri, 10 May 2019 12:57:02 +1000
From: "Tobin C. Harding" <tobin@kernel.org>
Message-ID: <20190510025702.GA10709@eros.localdomain>
References: <20190510025212.10109-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510025212.10109-1-tobin@kernel.org>
Subject: Re: [Bridge] [PATCH v2] bridge: Fix error path for
	kobject_init_and_add()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Tobin C. Harding" <tobin@kernel.org>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Tyler Hicks <tyhicks@canonical.com>, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

On Fri, May 10, 2019 at 12:52:12PM +1000, Tobin C. Harding wrote:

Please ignore - I forgot about netdev procedure and the merge window.
My bad.

Will re-send when you are open.

thanks,
Tobin.
