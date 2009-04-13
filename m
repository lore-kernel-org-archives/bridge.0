Date: Mon, 13 Apr 2009 08:00:09 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20090413080009.034a5e7f@nehalam>
In-Reply-To: <E9E3926FA9CDBF489EA1684042C8A026012DBAA9@zmy16exm72.ds.mot.com>
References: <E9E3926FA9CDBF489EA1684042C8A026012DBAA9@zmy16exm72.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Out of memory problem
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tekale Sharad-FHJN78 <FHJN78@motorola.com>
Cc: bridge@lists.linux-foundation.org

On Mon, 13 Apr 2009 16:58:20 +0800
"Tekale Sharad-FHJN78" <FHJN78@motorola.com> wrote:

> Hi, I'm using linux 2.6.21.5 and our kernel is freeze.
>  
> The problem is, if I create a Software bridge using $brctl command. and
> add two interfaces say, eth0.0 and eth0.1 using
> 
> $brctl addbr br-lan
> $brctl addif br-lan eth0.0
> $brctl addif br-lan eth0.1
>  
> and when i send traffic from a host connected to one port to host
> connected at other end, soon all the memory is dried up and and kernel
> crashes, 
> then oom-killer gets invoked which kills all the processes finally
> system reboots.
>  
> Can any one help me to refer to some patch  or point some location in
> code from where memory is failed to deallocate.
>  
> Thanks,
> Sharad.

Most likely, you have created a loop and are not running spanning
tree. When a loop happens, packets multiply until all resources are
exhausted.
