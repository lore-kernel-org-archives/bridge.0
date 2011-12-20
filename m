Return-Path: <vitas@nppfactor.kiev.ua>
From: Vitalii Demianets <vitas@nppfactor.kiev.ua>
Date: Tue, 20 Dec 2011 12:59:11 +0200
References: <201112131136.25919.vitas@nppfactor.kiev.ua>
	<20111213161613.0c59ab36@nehalam.linuxnetplumber.net>
	<201112141132.51867.vitas@nppfactor.kiev.ua>
In-Reply-To: <201112141132.51867.vitas@nppfactor.kiev.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201112201259.12086.vitas@nppfactor.kiev.ua>
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
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

Hello, Stephen!
I can not understand your silence.
There are issues fixed by the patch in question. For example, if the interface 
is left in blocking state after stp was turned off, that state is not 
stable - it can flip to forwarding state in unpredictable times, e.g. when 
_any other_ slave of the bridge goes up or down. Do you think user wants 
exactly that unpredictable state change?
Also, the code in question in function br_stp_stop(), namely 
br_port_state_selection(br) call, does exactly nothing except wasting cpu 
cycles. Isn't it worth fixing?

-- 
Vitalii Demianets
