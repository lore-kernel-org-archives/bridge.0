Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=Ds2wvtECzu5G+sbe/PTZH4BozCBYZnLrvBj4fntGmCU=;
	b=Y1Pom0tphXgtWMZT2uPph0QuYs8dF5AF+32WobRDMOYEREAzlDgSxQyM+/rNjOI4hE
	swX/zXSRXePq6xxJCltP7cQJf10+NhlZ3w0HHQr2txMx26I1DHNSXUtw5xT3xpuC6ZEu
	/SSui82cQMU7ee6+ACZQNCMGLvJUjQFuhNWWA=
References: <1503980568-35240-1-git-send-email-roopa@cumulusnetworks.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <4163d291-6aec-327d-8708-5a3d32078d3b@cumulusnetworks.com>
Date: Tue, 29 Aug 2017 13:13:44 +0300
MIME-Version: 1.0
In-Reply-To: <1503980568-35240-1-git-send-email-roopa@cumulusnetworks.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2] bridge: fdb add and delete
	tracepoints
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@cumulusnetworks.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, f.fainelli@gmail.com, bridge@lists.linux-foundation.org

On 29/08/17 07:22, Roopa Prabhu wrote:
> From: Roopa Prabhu <roopa@cumulusnetworks.com>
> 
> A few useful tracepoints to trace bridge forwarding
> database updates.
> 
> Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>
> ---
> v2 - address comments from Florian
> 
>  include/trace/events/bridge.h |   98 +++++++++++++++++++++++++++++++++++++++++
>  net/bridge/br_fdb.c           |    7 +++
>  net/core/net-traces.c         |    6 +++
>  3 files changed, 111 insertions(+)
>  create mode 100644 include/trace/events/bridge.h
> 

Very nice and useful, thanks!

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

