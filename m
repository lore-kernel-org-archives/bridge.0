Date: Tue, 8 May 2007 11:11:23 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] two fields are missing in brctl output when using /sys
Message-ID: <20070508111123.39cbb2d2@freekitty>
In-Reply-To: <1175803859.24828.3.camel@ragnarok>
References: <1175803859.24828.3.camel@ragnarok>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jeremy Jackson <jerj@coplanar.net>
Cc: bridge@linux-foundation.org

On Thu, 05 Apr 2007 16:10:59 -0400
Jeremy Jackson <jerj@coplanar.net> wrote:

> I've noticed for a while that 
> 
> # brctl showstp
> 
> output is showing 0 for port_no and  port_id
> 
> It seems that somewhere in 2.6 sysfs land the following items got
> printed in hexadecimal, and brctl code was parsing for decimal only
> 
> doug:/sys/class/net/eth0/brport# cat port_id
> 0x8001
> doug:/sys/class/net/eth0/brport# cat port_no
> 0x1
> 
> The following patch to bridge-utils (git and 1.2 release) lets it do the
> right thing:
> 
> diff -ur bridge-utils-1.2/libbridge/libbridge_devif.c
> bridge-utils/libbridge/lib
> bridge_devif.c
> --- bridge-utils-1.2/libbridge/libbridge_devif.c        2007-04-05
> 16:02:58.2870
> 22220 -0400
> +++ bridge-utils/libbridge/libbridge_devif.c    2007-04-05
> 14:51:19.362040447 -0
> 400
> @@ -56,7 +56,7 @@
>         if (!f) 
>                 fprintf(stderr, "%s: %s\n", dev, strerror(errno));
>         else {
> -               fscanf(f, "%i", &value);
> +               fscanf(f, "%d", &value);
>                 fclose(f);
>         }
>         return value;
> 

Applied manually, (your patch was backwards)

-- 
Stephen Hemminger <shemminger@linux-foundation.org>
