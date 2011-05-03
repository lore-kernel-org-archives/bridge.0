Date: Tue, 3 May 2011 09:28:12 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20110503092812.032524d8@nehalam>
In-Reply-To: <20110503162343.GB28712@vip.manty.net>
References: <20110503162343.GB28712@vip.manty.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bugs fixed on Debian's bridge-utils
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Santiago Garcia Mantinan <manty@debian.org>
Cc: Lennert Buytenhek <buytenh@gnu.org>, bridge@osdl.org

On Tue, 3 May 2011 18:23:43 +0200
Santiago Garcia Mantinan <manty@debian.org> wrote:

> Hi!
> 
> As the Debian's maintainer of bridge-utils on my last upload to Debian I
> cared to comment the source stating the bugs we had fixed on bridge-utils on
> Debian that are still opened on your upstream version, you can get the patch
> directly from our debian sources and forget about the debian dir, but I have
> cut that out for you and what remains is this:
> 
> --- bridge-utils-1.5.orig/doc/brctl.8
> +++ bridge-utils-1.5/doc/brctl.8
> @@ -89,7 +89,7 @@
>  .B brctl showmacs <brname>
>  shows a list of learned MAC addresses for this bridge.
>  
> -.B brctl setageingtime <brname> <time>
> +.B brctl setageing <brname> <time>
>  sets the ethernet (MAC) address ageing time, in seconds. After <time>
>  seconds of not having seen a frame coming from a certain address, the
>  bridge will time out (delete) that address from the Forwarding
> --- bridge-utils-1.5.orig/brctl/brctl.c
> +++ bridge-utils-1.5/brctl/brctl.c
> @@ -69,7 +69,8 @@
>  	argc -= optind;
>  	argv += optind;
>  	if ((cmd = command_lookup(*argv)) == NULL) {
> -		fprintf(stderr, "never heard of command [%s]\n", argv[1]);
> +/* Debian bug #406907 */
> +		fprintf(stderr, "never heard of command [%s]\n", argv[0]);
>  		goto help;
>  	}
>  	
> --- bridge-utils-1.5.orig/libbridge/libbridge_devif.c
> +++ bridge-utils-1.5/libbridge/libbridge_devif.c
> @@ -288,12 +288,16 @@
>  	char path[SYSFS_PATH_MAX];
>  	FILE *f;
>  
> -	snprintf(path, SYSFS_PATH_MAX, SYSFS_CLASS_NET "%s/%s", bridge, name);
> +/* Debian bug #496491 */
> +	snprintf(path, SYSFS_PATH_MAX, SYSFS_CLASS_NET "%s/bridge/%s", bridge, name);
>  
>  	f = fopen(path, "w");
>  	if (f) {
>  		ret = fprintf(f, "%ld\n", value);
>  		fclose(f);
> +/* Debian bug #574363 */
> +		if (errno)
> +			ret=-1;
>  	} else {
>  		/* fallback to old ioctl */
>  		struct ifreq ifr;
> @@ -355,6 +359,9 @@
>  	if (f) {
>  		ret = fprintf(f, "%ld\n", value);
>  		fclose(f);
> +/* Debian bug #574363 */
> +		if (errno)
> +			ret=-1;
>  	} else {
>  		int index = get_portno(bridge, ifname);
>  
> 
> If you need comments on the bugs or the solutions or want us to test
> different solutions for these bugs just let me know.
> 
> Thanks for your help.
> 
> Regards...

Ok. will fix (without comments)


-- 
