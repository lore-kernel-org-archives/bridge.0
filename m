Return-Path: <stephen@networkplumber.org>
Date: Tue, 25 Nov 2014 08:43:32 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20141125084332.7a261b17@urahara>
In-Reply-To: <CAPhYifHUARhGXbgUhB-Sd0y_sZj30CThAxToQJxp+FRtS1DM6Q@mail.gmail.com>
References: <CAPhYifHUARhGXbgUhB-Sd0y_sZj30CThAxToQJxp+FRtS1DM6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Put virbr0 in promiscuous mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Sagar Shedge <sagar.shedge92@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Mon, 24 Nov 2014 18:59:49 +0530
Sagar Shedge <sagar.shedge92@gmail.com> wrote:

> Steps followed :-
> 1. Add VM1 eth0 to virbr0
> 2. Add VM2 eth1 to virbr0
> 3. brctl setageing ovsbr0 0 ..(To put bridge in promiscuous)

ovsbr0 is Open Vswitch not linux bridge
