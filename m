Date: Thu, 2 Mar 2006 12:31:02 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] bridge MAC address
Message-ID: <20060302123102.04a82598@localhost.localdomain>
In-Reply-To: <37A954DFE3784244A7831AF8412790B56EB155@zil01exm61.ds.mot.com>
References: <37A954DFE3784244A7831AF8412790B56EB155@zil01exm61.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Levi Ariel-BAL023 <ariel.levi@motorola.com>
Cc: bridge@lists.osdl.org

On Thu, 2 Mar 2006 20:20:38 +0200
"Levi Ariel-BAL023" <ariel.levi@motorola.com> wrote:

> Hi,
> 
>  
> 
> I have notice that the bridge gets the "lowest" MAC address of its
> interfaces.
> 
> Function: br_stp_recalculate_bridge_id()
> 
>  
> 
> Is there a meaning behind this or not?
> 
>  
> 
> Thanks, 
> 
>  Ariel 
> 

It's part of the Spanning Tree Protocol in the 802.1d standard.
In later kernels you can reset the address to be the same as any
of the interfaces being bridged.
