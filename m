Date: Tue, 18 May 2004 08:54:21 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] BPDU generation problem
Message-Id: <20040518085421.5a2bae86@dell_ss3.pdx.osdl.net>
In-Reply-To: <s0aa7d92.047@EMAIL>
References: <s0aa7d92.047@EMAIL>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Kishore A K <kishoreak@myw.ltindia.com>
Cc: bridge@lists.osdl.org

On Tue, 18 May 2004 21:18:01 +0530
"Kishore A K" <kishoreak@myw.ltindia.com> wrote:

> Hi Stephen,
> 
> I have been studying the bridge source & analyzing its flow by putting printks
> at various places. I am using kernel 2.6.6. I found something really strange 
> happening..
> 
> I have setup a bridge with two ports. I havent enabled stp on the bridge. Which
> I have confirmed by doing a "brctl show" also. However from the printks I find 
> that BPDUs are getting generated & sent on the ports. Isnt this not supposed to 
> happen?
> 
> Regards,
> Kishore

Probably just a stupid bug. 
