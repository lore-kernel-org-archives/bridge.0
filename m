Date: Tue, 22 Feb 2011 09:07:29 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20110222090729.497fbb0a@nehalam>
In-Reply-To: <AANLkTikZfkSPWpEE45WMbjjjivxXYJpXyu8NQrv0x=FR@mail.gmail.com>
References: <AANLkTik-bRJEzLabppV=Vrd+psCDhC2W6hirsF=4+kaQ@mail.gmail.com>
	<20110221121340.1f92a378@nehalam>
	<AANLkTikZfkSPWpEE45WMbjjjivxXYJpXyu8NQrv0x=FR@mail.gmail.com>
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

On Tue, 22 Feb 2011 02:31:15 +0000
Rus Foster <twattycake@gmail.com> wrote:

> I moved the bridge to eth1 just to see if was a chipset issue. Same
> issue remains with some (but differnet IPs) not working
> 
> [root@8 ~]# brctl showstp eth1
> eth1
>  bridge id		8000.0025901d7135
>  designated root	8000.0025901d7135
>  root port		   0			path cost		   0
>  max age		  20.00			bridge max age		  20.00
>  hello time		   2.00			bridge hello time	   2.00
>  forward delay		   1.00			bridge forward delay	   1.00
>  ageing time		 300.01
>  hello timer		   1.12			tcn timer		   0.00
>  topology change timer	   0.00			gc timer		   0.02
>  flags			
> 
> 
> vifvm6032.0 (23)
>  port id		8017			state		     forwarding
>  designated root	8000.0025901d7135	path cost		 100
>  designated bridge	8000.0025901d7135	message age timer	   0.00
>  designated port	8017			forward delay timer	   0.00
>  designated cost	   0			hold timer		   0.12
>  flags			
> 
> vifvm6039.0 (25)
>  port id		8019			state		     forwarding
>  designated root	8000.0025901d7135	path cost		 100
>  designated bridge	8000.0025901d7135	message age timer	   0.00
>  designated port	8019			forward delay timer	   0.00
>  designated cost	   0			hold timer		   0.12
>  flags			
> 
> vifvm6038.0 (24)
>  port id		8018			state		     forwarding
>  designated root	8000.0025901d7135	path cost		 100
>  designated bridge	8000.0025901d7135	message age timer	   0.00
>  designated port	8018			forward delay timer	   0.00
>  designated cost	   0			hold timer		   0.12
>  flags			
> 
> vifvm6021.0 (22)
>  port id		8016			state		     forwarding
>  designated root	8000.0025901d7135	path cost		 100
>  designated bridge	8000.0025901d7135	message age timer	   0.00
>  designated port	8016			forward delay timer	   0.00
>  designated cost	   0			hold timer		   0.12
>  flags			
> 
> vifvm5953.0 (21)
>  port id		8015			state		     forwarding
>  designated root	8000.0025901d7135	path cost		 100
>  designated bridge	8000.0025901d7135	message age timer	   0.00
>  designated port	8015			forward delay timer	   0.00
>  designated cost	   0			hold timer		   0.12
>  flags			
> 
> vifvm6043.0 (20)
>  port id		8014			state		     forwarding
>  designated root	8000.0025901d7135	path cost		 100
>  designated bridge	8000.0025901d7135	message age timer	   0.00
>  designated port	8014			forward delay timer	   0.00
>  designated cost	   0			hold timer		   0.12
>  flags			
> 
> tap37.0 (19)
>  port id		8013			state		     forwarding
>  designated root	8000.0025901d7135	path cost		 100
>  designated bridge	8000.0025901d7135	message age timer	   0.00
>  designated port	8013			forward delay timer	   0.00
>  designated cost	   0			hold timer		   0.12
>  flags			
> 
> vifvm5906.0 (18)
>  port id		8012			state		       disabled
>  designated root	8000.0025901d7135	path cost		 100
>  designated bridge	8000.0025901d7135	message age timer	   0.00
>  designated port	8012			forward delay timer	   0.00
>  designated cost	   0			hold timer		   0.00
>  flags			
> 
> vifvm5907.0 (17)
>  port id		8011			state		     forwarding
>  designated root	8000.0025901d7135	path cost		 100
>  designated bridge	8000.0025901d7135	message age timer	   0.00
>  designated port	8011			forward delay timer	   0.00
>  designated cost	   0			hold timer		   0.12
>  flags			
> 
> vifvm5912.0 (16)
>  port id		8010			state		       disabled
>  designated root	8000.0025901d7135	path cost		 100
>  designated bridge	8000.0025901d7135	message age timer	   0.00
>  designated port	8010			forward delay timer	   0.00
>  designated cost	   0			hold timer		   0.00
>  flags			
> 
> tap32.0 (3)
>  port id		8003			state		     forwarding
>  designated root	8000.0025901d7135	path cost		 100
>  designated bridge	8000.0025901d7135	message age timer	   0.00
>  designated port	8003			forward delay timer	   0.00
>  designated cost	   0			hold timer		   0.12
>  flags			
> 
> vifvm5911.0 (15)
>  port id		800f			state		       disabled
>  designated root	8000.0025901d7135	path cost		 100
>  designated bridge	8000.0025901d7135	message age timer	   0.00
>  designated port	800f			forward delay timer	   0.00
>  designated cost	   0			hold timer		   0.00
>  flags			
> 
> tap29.0 (2)
>  port id		8002			state		     forwarding
>  designated root	8000.0025901d7135	path cost		 100
>  designated bridge	8000.0025901d7135	message age timer	   0.00
>  designated port	8002			forward delay timer	   0.00
>  designated cost	   0			hold timer		   0.12
>  flags			
> 
> vifvm5958.0 (14)
>  port id		800e			state		       disabled
>  designated root	8000.0025901d7135	path cost		 100
>  designated bridge	8000.0025901d7135	message age timer	   0.00
>  designated port	800e			forward delay timer	   0.00
>  designated cost	   0			hold timer		   0.00
>  flags			
> 
> tap28.0 (13)
>  port id		800d			state		     forwarding
>  designated root	8000.0025901d7135	path cost		 100
>  designated bridge	8000.0025901d7135	message age timer	   0.00
>  designated port	800d			forward delay timer	   0.00
>  designated cost	   0			hold timer		   0.11
>  flags			
> 
> vifvm5978.0 (12)
>  port id		800c			state		       disabled
>  designated root	8000.0025901d7135	path cost		 100
>  designated bridge	8000.0025901d7135	message age timer	   0.00
>  designated port	800c			forward delay timer	   0.00
>  designated cost	   0			hold timer		   0.00
>  flags			
> 
> tap22.0 (11)
>  port id		800b			state		     forwarding
>  designated root	8000.0025901d7135	path cost		 100
>  designated bridge	8000.0025901d7135	message age timer	   0.00
>  designated port	800b			forward delay timer	   0.00
>  designated cost	   0			hold timer		   0.11
>  flags			
> 
> vifvm5915.0 (10)
>  port id		800a			state		       disabled
>  designated root	8000.0025901d7135	path cost		 100
>  designated bridge	8000.0025901d7135	message age timer	   0.00
>  designated port	800a			forward delay timer	   0.00
>  designated cost	   0			hold timer		   0.00
>  flags			
> 
> tap17.0 (5)
>  port id		8005			state		     forwarding
>  designated root	8000.0025901d7135	path cost		 100
>  designated bridge	8000.0025901d7135	message age timer	   0.00
>  designated port	8005			forward delay timer	   0.00
>  designated cost	   0			hold timer		   0.11
>  flags			
> 
> vifvm5967.0 (9)
>  port id		8009			state		       disabled
>  designated root	8000.0025901d7135	path cost		 100
>  designated bridge	8000.0025901d7135	message age timer	   0.00
>  designated port	8009			forward delay timer	   0.00
>  designated cost	   0			hold timer		   0.00
>  flags			
> 
> vifvm5955.0 (8)
>  port id		8008			state		       disabled
>  designated root	8000.0025901d7135	path cost		 100
>  designated bridge	8000.0025901d7135	message age timer	   0.00
>  designated port	8008			forward delay timer	   0.00
>  designated cost	   0			hold timer		   0.00
>  flags			
> 
> vifvm5954.0 (7)
>  port id		8007			state		       disabled
>  designated root	8000.0025901d7135	path cost		 100
>  designated bridge	8000.0025901d7135	message age timer	   0.00
>  designated port	8007			forward delay timer	   0.00
>  designated cost	   0			hold timer		   0.00
>  flags			
> 
> vifvm5919.0 (6)
>  port id		8006			state		       disabled
>  designated root	8000.0025901d7135	path cost		 100
>  designated bridge	8000.0025901d7135	message age timer	   0.00
>  designated port	8006			forward delay timer	   0.00
>  designated cost	   0			hold timer		   0.00
>  flags			
> 
> vifvm5913.0 (4)
>  port id		8004			state		     forwarding
>  designated root	8000.0025901d7135	path cost		 100
>  designated bridge	8000.0025901d7135	message age timer	   0.00
>  designated port	8004			forward delay timer	   0.00
>  designated cost	   0			hold timer		   0.11
>  flags			
> 
> peth1 (1)
>  port id		8001			state		     forwarding
>  designated root	8000.0025901d7135	path cost		  19
>  designated bridge	8000.0025901d7135	message age timer	   0.00
>  designated port	8001			forward delay timer	   0.00
>  designated cost	   0			hold timer		   0.11
>  flags

Some of these are disabled. You probably have loops in your
network that STP is detecting.

-- 
