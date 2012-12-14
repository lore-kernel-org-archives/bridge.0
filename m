Return-Path: <shemminger@vyatta.com>
Date: Fri, 14 Dec 2012 09:11:24 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20121214091124.4123e3e4@nehalam.linuxnetplumber.net>
In-Reply-To: <1355464772-17712-1-git-send-email-amwang@redhat.com>
References: <1355464772-17712-1-git-send-email-amwang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] iproute2: update usage info of bridge monitor
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Cong Wang <amwang@redhat.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On Fri, 14 Dec 2012 13:59:32 +0800
Cong Wang <amwang@redhat.com> wrote:

> Cc: Stephen Hemminger <shemminger@vyatta.com>
> Signed-off-by: Cong Wang <amwang@redhat.com>
> 
> ---
> diff --git a/bridge/monitor.c b/bridge/monitor.c
> index 44e14d8..29bb931 100644
> --- a/bridge/monitor.c
> +++ b/bridge/monitor.c
> @@ -31,7 +31,7 @@ int prefix_banner;
>  
>  static void usage(void)
>  {
> -	fprintf(stderr, "Usage: bridge monitor\n");
> +	fprintf(stderr, "Usage: bridge monitor [file | link | fdb | mdb | all]\n");
>  	exit(-1);
>  }
>  

Applied.
