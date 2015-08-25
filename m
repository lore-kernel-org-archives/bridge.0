Return-Path: <stephen@networkplumber.org>
Date: Tue, 25 Aug 2015 14:21:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20150825142158.3e95b05a@urahara>
In-Reply-To: <55DCBB02.6050308@conversis.de>
References: <55DCBB02.6050308@conversis.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] vlan "aware" bridges
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Dennis Jacobfeuerborn <dennisml@conversis.de>
Cc: bridge@lists.linux-foundation.org

On Tue, 25 Aug 2015 20:59:14 +0200
Dennis Jacobfeuerborn <dennisml@conversis.de> wrote:

> Hi,
> through the cumulus documentation I learned that there apparently now
> exists a way to create a single bridge that allows vlan filtering rather
> than the old method using an individual bridge for each vlan.
> That documentation only uses this new bridge model in the context of
> their new ifupdown2 tool though.
> 
> Is there any practical documentation out there or some
> tutorials/examples that explain how to use/configure such a vlan aware
> bridge using the basic bridge/ip toolset?
> 
> Regards,
>   Dennis

Did you look in current iproute2 man pages.
