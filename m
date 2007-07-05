Date: Wed, 4 Jul 2007 17:49:29 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] How many interfaces within one bridge
Message-ID: <20070704174929.61d86066@freepuppy.localdomain.hemminger.net>
In-Reply-To: <000001c7bdeb$6d74bdc0$c7eaa8c0@zs53e005567e65>
References: <000001c7bdeb$6d74bdc0$c7eaa8c0@zs53e005567e65>
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
To: Chris-BROWAN <chris.xiong@browan.com>
Cc: bridge@linux-foundation.org

On Wed, 4 Jul 2007 11:28:22 +0800
"Chris-BROWAN" <chris.xiong@browan.com> wrote:

> Dear Sir or Madam:
> 
>  
> 
> I just wondered how many interfaces at most can be added into one Linux
> Bridge.
> 

There is a limit of 1024 (in recent 2.6 versions).
The limit is because the Spanning Tree Protocol only has 16 bits
for port id and priority.  Originally, the split was 8/8 but by
making it 6/10 there is more room for ports and less for priority.

-- 
Stephen Hemminger <shemminger@linux-foundation.org>
