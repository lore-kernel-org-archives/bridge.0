Return-Path: <shemminger@vyatta.com>
Date: Tue, 13 Dec 2011 16:16:13 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20111213161613.0c59ab36@nehalam.linuxnetplumber.net>
In-Reply-To: <201112131136.25919.vitas@nppfactor.kiev.ua>
References: <201112131136.25919.vitas@nppfactor.kiev.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: push blocking slaves to forwarding
 when turning stp off
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vitalii Demianets <vitas@nppfactor.kiev.ua>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On Tue, 13 Dec 2011 11:36:25 +0200
Vitalii Demianets <vitas@nppfactor.kiev.ua> wrote:

> If there is a slave in blocking state when stp is turned off, that slave will 
> remain in blocking state for indefinitely long time until interface state 
> changed. We should push all blocking slaves into forwarding state after 
> turning stp off.
> 
> Signed-off-by: Vitalii Demianets <vitas@nppfactor.kiev.ua>

Maybe. But if the port was in the blocking state then STP must have
decided there was a loop in the network if that port was used.
Therefore blindly putting the port into forwarding state could cause
disastrous network flood.


The user can force the port back out of blocking state (via sysfs).

