Message-ID: <43318C62.8010005@mvista.com>
Date: Wed, 21 Sep 2005 09:37:54 -0700
From: Tom McNeal <tmcneal@mvista.com>
MIME-Version: 1.0
Subject: Re: [Bridge] stresstest.sh
References: <432B3C8E.1070503@mvista.com>	<20050916151835.3bc8e5cc@dxpl.pdx.osdl.net>	<432EDE02.8090106@mvista.com>
	<20050919093412.0ea59042@dxpl.pdx.osdl.net>
In-Reply-To: <20050919093412.0ea59042@dxpl.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org

Hi -

We are still hitting a panic while running the bridge-utils-1.0.6
stress tests, apparently due to a page fault in the kernel
at address 0, or at least we see that before seeing the panic
message (Kernel panic: Aiee, killing interrupt handler!)

Anyway, the bridge code in the 2.4.17 kernel (net/bridge) was
upgraded to 2.4.31 code as suggested.  In addition, the process
running at the time of the panic is the 'brctl delbr brtmp1' call
in the newdel function of the stress tests, which is looping with
addbr and delbr calls to create and delete a temporary, unused bridge.

Any suggestions?

Tom

Stephen Hemminger wrote:
> 
> You probably could just copy whole net/bridge directory over from
> current 2.4 tree.
> 

-- 
Tom McNeal
MontaVista Software
408-992-4459

