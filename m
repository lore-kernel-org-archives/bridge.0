Date: Mon, 21 Feb 2011 12:13:40 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20110221121340.1f92a378@nehalam>
In-Reply-To: <AANLkTik-bRJEzLabppV=Vrd+psCDhC2W6hirsF=4+kaQ@mail.gmail.com>
References: <AANLkTik-bRJEzLabppV=Vrd+psCDhC2W6hirsF=4+kaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bug? Some interfaces not forwarding
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Rus Foster <twattycake@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Mon, 21 Feb 2011 15:18:15 +0000
Rus Foster <twattycake@gmail.com> wrote:

> We've got an issue with some Xen guests and not forwarding packets on
> the bridge for some interfaces but not all others
> 
> The main server is 109.169.72.130.
> 
> The bridge is eth0 (with peth0)
> 
> The IP 109.169.72.249 assigned to vifvm6039.0 works
> 
> The IP 109.169.72.251 assigned to vifvm5927.0 doesn't
> 
> 
> [root@8 tmp]# brctl show
> bridge name	bridge id		STP enabled	interfaces
> eth0		8000.0025901d7134	yes		vifvm5955.0
> 							tap46.0
> 							vifvm5911.0
> 							tap45.0
> 							vifvm5927.0
> 							vifvm5912.0
> 							tap43.0
> 							vifvm5967.0
> 							tap40.0
> 							vifvm5913.0
> 							vifvm6043.0
> 							vifvm6032.0
> 							vifvm6021.0
> 							vifvm5953.0
> 							vifvm5907.0
> 							vifvm5954.0
> 							tap11.0
> 							vifvm6039.0
> 							vifvm6038.0
> 							tap4.0
> 							vifvm5919.0
> 							tap3.0
> 							vifvm5915.0
> 							peth0
> 
> 
> [root@8 tmp]# brctl showmacs eth0
> port no	mac addr		is local?	ageing timer
>   1	00:0d:29:43:df:ae	no		   0.18
>  14	00:16:3e:0f:9b:6c	no		   0.53
>  16	00:16:3e:14:26:36	no		  24.73
>   7	00:16:3e:1d:7e:40	no		 104.61
>   5	00:16:3e:37:62:9f	no		  55.77
>  18	00:16:3e:47:27:f9	no		 102.34
>  12	00:16:3e:70:56:f2	no		 103.13
>  17	00:16:3e:75:4a:a5	no		 101.74
>  19	00:16:3e:75:f4:b1	no		  40.01
>  23	00:16:3e:76:f7:4d	no		  33.89
>  13	00:16:3e:79:84:cb	no		 105.13
>  15	00:16:3e:7a:59:ac	no		  26.46
>   2	00:16:3e:8d:1e:4d	no		   0.20
>   8	00:16:3e:96:47:c6	no		 105.13
>  10	00:16:3e:9f:3a:69	no		  14.17
>  21	00:16:3e:bc:c6:46	no		 102.14
>   9	00:16:3e:f2:03:05	no		  11.45
>   1	00:23:9c:12:a1:80	no		   0.00
>   1	00:25:90:1d:71:34	yes		   0.00
>  23	3a:48:46:fa:0f:f3	yes		   0.00
>   2	62:7b:18:61:a1:f7	yes		   0.00
>  21	66:c2:21:04:72:26	yes		   0.00
>  19	7a:8b:f3:51:81:f4	yes		   0.00
>  10	a6:7f:67:8e:e5:45	yes		   0.00
>   5	c2:2d:30:b5:8e:44	yes		   0.00
>   7	ca:a1:4b:0f:7d:c9	yes		   0.00
>  13	fe:ff:ff:ff:ff:ff	yes		   0.00
> 
> root@8 tmp]# uname -a
> Linux 8.xn.nj.damnvps.com 2.6.18-243.el5xen #1 SMP Mon Feb 7 19:07:01
> EST 2011 x86_64 x86_64 x86_64 GNU/Linux
> [root@8 tmp]# cat /etc/redhat-release
> CentOS release 5.5 (Final)
> 
> 
> From the server 109.169.72.249 and 109.169.72.251 can be pinged
> 
> From externally only 109.169.72.249 can be
> 
> There are NO iptables, ebtables rules
> 
> Default gateway is defined correctly in each guests. If we reboot the
> server then differenet interfaces work/don't work so its not a VM
> configuration issue
> 
> I'm totally out of ideas so thinking it might be a bug
> 
> Feedback gratefully received

pseudo ethernet doesn't do promicious correctly? you should use
eth0 not peth0.

What is output of brctl showstp br0?

-- 
