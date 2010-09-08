// Written in the D programming language.

/**
Defines generic _containers.

Macros:
WIKI = Phobos/StdContainer
TEXTWITHCOMMAS = $0
LEADINGROW = <tr style=leadingrow bgcolor=#E4E9EF><td colspan=3><b><em>$0</em></b></td></tr>

Copyright: Copyright 2010- Andrei Alexandrescu.

License: Distributed under the Boost Software License, Version 1.0.
(See accompanying file LICENSE_1_0.txt or copy at $(WEB
boost.org/LICENSE_1_0.txt)).

Authors: $(WEB erdani.com, Andrei Alexandrescu)

$(BOOKTABLE $(TEXTWITHCOMMAS Container primitives. Below, $(D C) means
a _container type, $(D c) is a value of _container type, $(D l$(SUB
x)) represents the effective length of value $(D x), which could be a
single element (in which case $(D l$(SUB x)) is $(D 1)), a _container,
or a range.),

$(TR $(TH Syntax) $(TH $(BIGOH &middot;)) $(TH Description))

$(TR $(TDNW $(D C(x))) $(TDNW $(D l$(SUB x))) $(TD Creates a
_container of type $(D C) from either another _container or a range.))

$(TR $(TDNW $(D c.dup)) $(TDNW $(D l$(SUB c))) $(TD Returns a
duplicate of the _container.))

$(TR $(TDNW $(D c ~ x)) $(TDNW $(D l$(SUB c) + l$(SUB x))) $(TD
Returns the concatenation of $(D c) and $(D r). $(D x) may be a single
element or an input range.))

$(TR $(TDNW $(D x ~ c)) $(TDNW $(D l$(SUB c) + l$(SUB x))) $(TD
Returns the concatenation of $(D x) and $(D c).  $(D x) may be a
single element or an input range type.))

$(LEADINGROW Iteration)

$(TR  $(TD $(D c.Range)) $(TD) $(TD The primary range
type associated with the _container.))

$(TR $(TD $(D c[])) $(TDNW $(D log l$(SUB c))) $(TD Returns a range
iterating over the entire _container, in a _container-defined order.))

$(TR $(TDNW $(D c[a, b])) $(TDNW $(D log l$(SUB c))) $(TD Fetches a
portion of the _container from key $(D a) to key $(D b).))

$(LEADINGROW Capacity)

$(TR $(TD $(D c.empty)) $(TD $(D 1)) $(TD Returns $(D true) if the
_container has no elements, $(D false) otherwise.))

$(TR  $(TD $(D c.length)) $(TDNW $(D log l$(SUB c))) $(TD Returns the
number of elements in the _container.))

$(TR $(TDNW $(D c.length = n)) $(TDNW $(D l$(SUB c) + n)) $(TD Forces
the number of elements in the _container to $(D n). If the _container
ends up growing, the added elements are initialized in a
_container-dependent manner (usually with $(D T.init)).))

$(TR $(TD $(D c.capacity)) $(TDNW $(D log l$(SUB c))) $(TD Returns the
maximum number of elements that can be stored in the _container
without triggering a reallocation.))

$(TR $(TD $(D c.reserve(x))) $(TD $(D l$(SUB c))) $(TD Forces $(D
capacity) to at least $(D x) without reducing it.))

$(LEADINGROW Access)

$(TR $(TDNW $(D c.front)) $(TDNW $(D log l$(SUB c))) $(TD Returns the
first element of the _container, in a _container-defined order.))

$(TR $(TDNW $(D c.moveFront)) $(TDNW $(D log l$(SUB c))) $(TD
Destructively reads and returns the first element of the
_container. The slot is not removed from the _container; it is left
initalized with $(D T.init). This routine need not be defined if $(D
front) returns a $(D ref).))

$(TR $(TDNW $(D c.front = v)) $(TDNW $(D log l$(SUB c))) $(TD Assigns
$(D v) to the first element of the _container.))

$(TR $(TDNW $(D c.back)) $(TDNW $(D log l$(SUB c))) $(TD Returns the
last element of the _container, in a _container-defined order.))

$(TR $(TDNW $(D c.moveBack)) $(TDNW $(D log l$(SUB c))) $(TD
Destructively reads and returns the first element of the
container. The slot is not removed from the _container; it is left
initalized with $(D T.init). This routine need not be defined if $(D
front) returns a $(D ref).))

$(TR $(TDNW $(D c.back = v)) $(TDNW $(D log l$(SUB c))) $(TD Assigns
$(D v) to the last element of the _container.))

$(TR $(TDNW $(D c[x])) $(TDNW $(D log l$(SUB c))) $(TD Provides
indexed access into the _container. The index type is
_container-defined. A container may define several index types (and
consequently overloaded indexing).))

$(TR  $(TDNW $(D c.moveAt(x))) $(TDNW $(D log l$(SUB c))) $(TD
Destructively reads and returns the value at position $(D x). The slot
is not removed from the _container; it is left initialized with $(D
T.init).))

$(TR  $(TDNW $(D c[x] = v)) $(TDNW $(D log l$(SUB c))) $(TD Sets
element at specified index into the _container.))

$(TR  $(TDNW $(D c[x] $(I op)= v)) $(TDNW $(D log l$(SUB c)))
$(TD Performs read-modify-write operation at specified index into the
_container.))

$(LEADINGROW Operations)

$(TR $(TDNW $(D e in c)) $(TDNW $(D log l$(SUB c))) $(TD
Returns nonzero if e is found in $(D c).))

$(TR  $(TDNW $(D c.lowerBound(v))) $(TDNW $(D log l$(SUB c))) $(TD
Returns a range of all elements strictly less than $(D v).))

$(TR  $(TDNW $(D c.upperBound(v))) $(TDNW $(D log l$(SUB c))) $(TD
Returns a range of all elements strictly greater than $(D v).))

$(TR  $(TDNW $(D c.equalRange(v))) $(TDNW $(D log l$(SUB c))) $(TD
Returns a range of all elements in $(D c) that are equal to $(D v).))

$(LEADINGROW Modifiers)

$(TR $(TDNW $(D c ~= x)) $(TDNW $(D l$(SUB c) + l$(SUB x)))
$(TD Appends $(D x) to $(D c). $(D x) may be a single element or an
input range type.))

$(TR  $(TDNW $(D c.clear())) $(TDNW $(D l$(SUB c))) $(TD Removes all
elements in $(D c).))

$(TR  $(TDNW $(D c.insert(x))) $(TDNW $(D l$(SUB x) * log l$(SUB c)))
$(TD Inserts $(D x) in $(D c) at a position (or positions) chosen by $(D c).))

$(TR  $(TDNW $(D c.stableInsert(x)))
$(TDNW $(D l$(SUB x) * log l$(SUB c))) $(TD Same as $(D c.insert(x)),
but is guaranteed to not invalidate any ranges.))

$(TR  $(TDNW $(D c.linearInsert(v))) $(TDNW $(D l$(SUB c))) $(TD Same
as $(D c.insert(v)) but relaxes complexity to linear.))

$(TR  $(TDNW $(D c.stableLinearInsert(v))) $(TDNW $(D l$(SUB c)))
$(TD Same as $(D c.stableInsert(v)) but relaxes complexity to linear.))

$(TR  $(TDNW $(D c.removeAny())) $(TDNW $(D log l$(SUB c)))
$(TD Removes some element from $(D c) and returns it.))

$(TR  $(TDNW $(D c.stableRemoveAny(v))) $(TDNW $(D log l$(SUB c)))
$(TD Same as $(D c.removeAny(v)), but is guaranteed to not invalidate any
iterators.))

$(TR  $(TDNW $(D c.insertFront(v))) $(TDNW $(D log l$(SUB c)))
$(TD Inserts $(D v) at the front of $(D c).))

$(TR  $(TDNW $(D c.stableInsertFront(v))) $(TDNW $(D log l$(SUB c)))
$(TD Same as $(D c.insertFront(v)), but guarantees no ranges will be
invalidated.))

$(TR  $(TDNW $(D c.insertBack(v))) $(TDNW $(D log l$(SUB c)))
$(TD Inserts $(D v) at the back of $(D c).))

$(TR  $(TDNW $(D c.stableInsertBack(v))) $(TDNW $(D log l$(SUB c)))
$(TD Same as $(D c.insertBack(v)), but guarantees no ranges will be
invalidated.))

$(TR  $(TDNW $(D c.removeFront())) $(TDNW $(D log l$(SUB c)))
$(TD Removes the element at the front of $(D c).))

$(TR  $(TDNW $(D c.stableRemoveFront())) $(TDNW $(D log l$(SUB c)))
$(TD Same as $(D c.removeFront()), but guarantees no ranges will be
invalidated.))

$(TR  $(TDNW $(D c.removeBack())) $(TDNW $(D log l$(SUB c)))
$(TD Removes the value at the back of $(D c).))

$(TR  $(TDNW $(D c.stableRemoveBack())) $(TDNW $(D log l$(SUB c)))
$(TD Same as $(D c.removeBack()), but guarantees no ranges will be
invalidated.))

$(TR  $(TDNW $(D c.remove(r))) $(TDNW $(D l$(SUB r) * log l$(SUB c)))
$(TD Removes range $(D r) from $(D c).))

$(TR  $(TDNW $(D c.stableRemove(r)))
$(TDNW $(D l$(SUB r) * log l$(SUB c)))
$(TD Same as $(D c.remove(r)), but guarantees iterators are not
invalidated.))

$(TR  $(TDNW $(D c.linearRemove(r))) $(TDNW $(D l$(SUB c)))
$(TD Removes range $(D r) from $(D c).))

$(TR  $(TDNW $(D c.stableLinearRemove(r))) $(TDNW $(D l$(SUB c)))
$(TD Same as $(D c.linearRemove(r)), but guarantees iterators are not
invalidated.))

$(TR  $(TDNW $(D c.removeKey(k))) $(TDNW $(D log l$(SUB c)))
$(TD Removes an element from $(D c) by using its key $(D k).
The key's type is defined by the _container.))

$(TR  $(TDNW $(D )) $(TDNW $(D )) $(TD ))

)
 */
module std.container;

import core.memory, core.stdc.stdlib, core.stdc.string, std.algorithm,
    std.conv, std.exception, std.functional, std.range, std.traits,
    std.typecons, std.typetuple;
version(unittest) import std.stdio;

/* The following documentation and type $(D TotalContainer) are
intended for developers only.

$(D TotalContainer) is an unimplemented container that illustrates a
host of primitives that a container may define. It is to some extent
the bottom of the conceptual container hierarchy. A given container
most often will choose to only implement a subset of these primitives,
and define its own additional ones. Adhering to the standard primitive
names below allows generic code to work independently of containers.

Things to remember: any container must be a reference type, whether
implemented as a $(D class) or $(D struct). No primitive below
requires the container to escape addresses of elements, which means
that compliant containers can be defined to use reference counting or
other deterministic memory management techniques.

A container may choose to define additional specific operations. The
only requirement is that those operations bear different names than
the ones below, lest user code gets confused.

Complexity of operations should be interpreted as "at least as good
as". If an operation is required to have $(BIGOH n) complexity, it
could have anything lower than that, e.g. $(BIGOH log(n)). Unless
specified otherwise, $(D n) inside a $(BIGOH) expression stands for
the number of elements in the container.
 */
struct TotalContainer(T)
{
/**
If the container has a notion of key-value mapping, $(D KeyType)
defines the type of the key of the container.
 */
    alias T KeyType;

/**
If the container has a notion of multikey-value mapping, $(D
KeyTypes[k]), where $(D k) is a zero-based unsigned number, defines
the type of the $(D k)th key of the container.

A container may define both $(D KeyType) and $(D KeyTypes), e.g. in
the case it has the notion of primary/preferred key.
 */
    alias TypeTuple!(T) KeyTypes;

/**
If the container has a notion of key-value mapping, $(D ValueType)
defines the type of the value of the container. Typically, a map-style
container mapping values of type $(D K) to values of type $(D V)
defines $(D KeyType) to be $(D K) and $(D ValueType) to be $(D V).
 */
    alias T ValueType;

/**
Defines the container's primary range, which embodies one of the
ranges defined in $(XREFMODULE range).

Generally a container may define several types of ranges.
 */
    struct Range
    {
        /// Range primitives.
        @property bool empty()
        {
            assert(0);
        }
        /// Ditto
        @property T front()
        {
            assert(0);
        }
        /// Ditto
        T moveFront()
        {
            assert(0);
        }
        /// Ditto
        void popFront()
        {
            assert(0);
        }
        /// Ditto
        @property T back()
        {
            assert(0);
        }
        /// Ditto
        T moveBack()
        {
            assert(0);
        }
        /// Ditto
        void popBack()
        {
            assert(0);
        }
        /// Ditto
        T opIndex(size_t i)
        {
            assert(0);
        }
        /// Ditto
        void opIndexAssign(T value, uint i)
        {
            assert(0);
        }
        /// Ditto
        void opIndexOpAssign(string op)(T value, uint i)
        {
            assert(0);
        }
        /// Ditto
        T moveAt(size_t i)
        {
            assert(0);
        }
        /// Ditto
        @property size_t length()
        {
            assert(0);
        }
    }

/**
Property returning $(D true) if and only if the container has no
elements.

Complexity: $(BIGOH 1)
 */
    @property bool empty()
    {
        assert(0);
    }

/**
Returns a duplicate of the container. The elements themselves are not
transitively duplicated.

Complexity: $(BIGOH n).
 */
    @property TotalContainer dup()
    {
        assert(0);
    }

/**
Returns the number of elements in the container.

Complexity: $(BIGOH log(n)).
*/
    @property size_t length()
    {
        assert(0);
    }

/**
Returns the maximum number of elements the container can store without
(a) allocating memory, (b) invalidating iterators upon insertion.

Complexity: $(BIGOH log(n)).
 */
    @property size_t capacity()
    {
        assert(0);
    }

/**
Ensures sufficient capacity to accommodate $(D n) elements.

Postcondition: $(D capacity >= n)

Complexity: $(BIGOH log(e - capacity)) if $(D e > capacity), otherwise
$(BIGOH 1).
 */
    void reserve(size_t e)
    {
        assert(0);
    }

/**
Returns a range that iterates over all elements of the container, in a
container-defined order. The container should choose the most
convenient and fast method of iteration for $(D opSlice()).

Complexity: $(BIGOH log(n))
 */
    Range opSlice()
    {
        assert(0);
    }

    /**
       Returns a range that iterates the container between two
       specified positions.

       Complexity: $(BIGOH log(n))
     */
    Range opSlice(size_t a, size_t b)
    {
        assert(0);
    }

/**
Forward to $(D opSlice().front) and $(D opSlice().back), respectively.

Complexity: $(BIGOH log(n))
 */
    @property T front()
    {
        assert(0);
    }
    /// Ditto
    T moveFront()
    {
        assert(0);
    }
    /// Ditto
    @property T back()
    {
        assert(0);
    }
    /// Ditto
    T moveBack()
    {
        assert(0);
    }

/**
Indexing operators yield or modify the value at a specified index.
 */
    /**
       Indexing operators yield or modify the value at a specified index.
     */
    ValueType opIndex(KeyType)
    {
        assert(0);
    }
    /// ditto
    void opIndexAssign(KeyType)
    {
        assert(0);
    }
    /// ditto
    void opIndexOpAssign(string op)(KeyType)
    {
        assert(0);
    }
    T moveAt(size_t i)
    {
        assert(0);
    }

/**
$(D k in container) returns true if the given key is in the container.
 */
    bool opBinary(string op)(KeyType k) if (op == "in")
    {
        assert(0);
    }

/**
Returns a range of all elements containing $(D k) (could be empty or a
singleton range).
 */
    Range equalRange(KeyType k)
    {
        assert(0);
    }

/**
Returns a range of all elements with keys less than $(D k) (could be
empty or a singleton range). Only defined by containers that store
data sorted at all times.
 */
    Range lowerBound(KeyType k)
    {
        assert(0);
    }

/**
Returns a range of all elements with keys larger than $(D k) (could be
empty or a singleton range).  Only defined by containers that store
data sorted at all times.
 */
    Range upperBound(KeyType k)
    {
        assert(0);
    }

/**
Returns a new container that's the concatenation of $(D this) and its
argument. $(D opBinaryRight) is only defined if $(D Stuff) does not
define $(D opBinary).

Complexity: $(BIGOH n + m), where m is the number of elements in $(D
stuff)
 */
    TotalContainer opBinary(string op)(Stuff rhs) if (op == "~")
    {
        assert(0);
    }

    /// ditto
    TotalContainer opBinaryRight(string op)(Stuff lhs) if (op == "~")
    {
        assert(0);
    }

/**
Forwards to $(D insertAfter(this[], stuff)).
 */
    void opOpAssign(string op)(Stuff stuff) if (op == "~")
    {
        assert(0);
    }

/**
Removes all contents from the container. The container decides how $(D
capacity) is affected.

Postcondition: $(D empty)

Complexity: $(BIGOH n)
 */
    void clear()
    {
        assert(0);
    }

/**
Sets the number of elements in the container to $(D newSize). If $(D
newSize) is greater than $(D length), the added elements are added to
unspecified positions in the container and initialized with $(D
.init).

Complexity: $(BIGOH abs(n - newLength))

Postcondition: $(D _length == newLength)
 */
    @property void length(size_t newLength)
    {
        assert(0);
    }

/**
Inserts $(D stuff) in an unspecified position in the
container. Implementations should choose whichever insertion means is
the most advantageous for the container, but document the exact
behavior. $(D stuff) can be a value convertible to the element type of
the container, or a range of values convertible to it.

The $(D stable) version guarantees that ranges iterating over the
container are never invalidated. Client code that counts on
non-invalidating insertion should use $(D stableInsert). Such code would
not compile against containers that don't support it.

Returns: The number of elements added.

Complexity: $(BIGOH m * log(n)), where $(D m) is the number of
elements in $(D stuff)
 */
    size_t insert(Stuff)(Stuff stuff)
    {
        assert(0);
    }
    ///ditto
    size_t stableInsert(Stuff)(Stuff stuff)
    {
        assert(0);
    }

/**
Same as $(D insert(stuff)) and $(D stableInsert(stuff)) respectively,
but relax the complexity constraint to linear.
 */
    size_t linearInsert(Stuff)(Stuff stuff)
    {
        assert(0);
    }
    ///ditto
    size_t stableLinearInsert(Stuff)(Stuff stuff)
    {
        assert(0);
    }

/**
Picks one value in an unspecified position in the container, removes
it from the container, and returns it. Implementations should pick the
value that's the most advantageous for the container, but document the
exact behavior. The stable version behaves the same, but guarantees that
ranges iterating over the container are never invalidated.

Precondition: $(D !empty)

Returns: The element removed.

Complexity: $(BIGOH log(n)).
 */
    T removeAny()
    {
        assert(0);
    }
    /// ditto
    T stableRemoveAny()
    {
        assert(0);
    }

/**
Inserts $(D value) to the front or back of the container. $(D stuff)
can be a value convertible to the container's element type or a range
of values convertible to it. The stable version behaves the same, but
guarantees that ranges iterating over the container are never
invalidated.

Returns: The number of elements inserted

Complexity: $(BIGOH log(n)).
 */
    size_t insertFront(Stuff)(Stuff stuff)
    {
        assert(0);
    }
    /// ditto
    size_t stableInsertFront(Stuff)(Stuff stuff)
    {
        assert(0);
    }
    /// ditto
    size_t insertBack(Stuff)(Stuff stuff)
    {
        assert(0);
    }
    /// ditto
    size_t stableInsertBack(T value)
    {
        assert(0);
    }

/**
Removes the value at the front or back of the container. The stable
version behaves the same, but guarantees that ranges iterating over
the container are never invalidated. The optional parameter $(D
howMany) instructs removal of that many elements. If $(D howMany > n),
all elements are removed and no exception is thrown.

Precondition: $(D !empty)

Complexity: $(BIGOH log(n)).
 */
    void removeFront()
    {
        assert(0);
    }
    /// ditto
    void stableRemoveFront()
    {
        assert(0);
    }
    /// ditto
    void removeBack()
    {
        assert(0);
    }
    /// ditto
    void stableRemoveBack()
    {
        assert(0);
    }

/**
Removes $(D howMany) values at the front or back of the
container. Unlike the unparameterized versions above, these functions
do not throw if they could not remove $(D howMany) elements. Instead,
if $(D howMany > n), all elements are removed. The returned value is
the effective number of elements removed. The stable version behaves
the same, but guarantees that ranges iterating over the container are
never invalidated.

Returns: The number of elements removed

Complexity: $(BIGOH howMany * log(n)).
 */
    size_t removeFront(size_t howMany)
    {
        assert(0);
    }
    /// ditto
    size_t stableRemoveFront(size_t howMany)
    {
        assert(0);
    }
    /// ditto
    size_t removeBack(size_t howMany)
    {
        assert(0);
    }
    /// ditto
    size_t stableRemoveBack(size_t howMany)
    {
        assert(0);
    }

/**
Removes all values corresponding to key $(D k).

Complexity: $(BIGOH m * log(n)), where $(D m) is the number of
elements with the same key.

Returns: The number of elements removed.
 */
    size_t removeKey(KeyType k)
    {
        assert(0);
    }

/**
Inserts $(D stuff) before, after, or instead range $(D r), which must
be a valid range previously extracted from this container. $(D stuff)
can be a value convertible to the container's element type or a range
of objects convertible to it. The stable version behaves the same, but
guarantees that ranges iterating over the container are never
invalidated.

Returns: The number of values inserted.

Complexity: $(BIGOH n + m), where $(D m) is the length of $(D stuff)
 */
    size_t insertBefore(Stuff)(Range r, Stuff stuff)
    {
        assert(0);
    }
    /// ditto
    size_t stableInsertBefore(Stuff)(Range r, Stuff stuff)
    {
        assert(0);
    }
    /// ditto
    size_t insertAfter(Stuff)(Range r, Stuff stuff)
    {
        assert(0);
    }
    /// ditto
    size_t stableInsertAfter(Stuff)(Range r, Stuff stuff)
    {
        assert(0);
    }
    /// ditto
    size_t replace(Stuff)(Range r, Stuff stuff)
    {
        assert(0);
    }
    /// ditto
    size_t stableReplace(Stuff)(Range r, Stuff stuff)
    {
        assert(0);
    }

/**
Removes all elements belonging to $(D r), which must be a range
obtained originally from this container. The stable version behaves the
same, but guarantees that ranges iterating over the container are
never invalidated.

Returns: A range spanning the remaining elements in the container that
initially were right after $(D r).

Complexity: $(BIGOH m * log(n)), where $(D m) is the number of
elements in $(D r)
 */
    Range remove(Range r)
    {
        assert(0);
    }
    /// ditto
    Range stableRemove(Range r)
    {
        assert(0);
    }

/**
Same as $(D remove) above, but has complexity relaxed to linear.

Returns: A range spanning the remaining elements in the container that
initially were right after $(D r).

Complexity: $(BIGOH n)
 */
    Range linearRemove(Range r)
    {
        assert(0);
    }
    /// ditto
    Range stableLinearRemove(Range r)
    {
        assert(0);
    }
}

unittest {
    TotalContainer!int test;
}

/**
Returns an initialized container. This function is mainly for
eliminating construction differences between $(D class) containers and
$(D struct) containers.
 */
Container make(Container, T...)(T arguments) if (is(Container == struct))
{
    static if (T.length == 0)
        static assert(false, "You must pass at least one argument");
    else
        return Container(arguments);
}

/// ditto
Container make(Container, T...)(T arguments) if (is(Container == class))
{
    return new Container(arguments);
}

/**
   Implements a simple and fast singly-linked list.
 */
struct SList(T)
{
    private struct Node
    {
        T _payload;
        Node * _next;
        this(T a, Node* b) { _payload = a; _next = b; }
    }
    private Node * _root;

    private static Node * findLastNode(Node * n)
    {
        assert(n);
        auto ahead = n._next;
        while (ahead)
        {
            n = ahead;
            ahead = n._next;
        }
        return n;
    }

    private static Node * findLastNode(Node * n, size_t limit)
    {
        assert(n && limit);
        auto ahead = n._next;
        while (ahead)
        {
            if (!--limit) break;
            n = ahead;
            ahead = n._next;
        }
        return n;
    }

    private static Node * findNode(Node * n, Node * findMe)
    {
        assert(n);
        auto ahead = n._next;
        while (ahead != findMe)
        {
            n = ahead;
            enforce(n);
            ahead = n._next;
        }
        return n;
    }

/**
Constructor taking a number of nodes
     */
    this(U)(U[] values...) if (isImplicitlyConvertible!(U, T))
    {
        insertFront(values);
    }

/**
Constructor taking an input range
     */
    this(Stuff)(Stuff stuff)
    if (isInputRange!Stuff
            && isImplicitlyConvertible!(ElementType!Stuff, T)
            && !is(Stuff == T[]))
    {
        insertFront(stuff);
    }

/**
Comparison for equality.

Complexity: $(BIGOH min(n, n1)) where $(D n1) is the number of
elements in $(D rhs).
     */
    bool opEquals(ref const SList rhs) const
    {
        const(Node) * n1 = _root, n2 = rhs._root;

        for (;; n1 = n1._next, n2 = n2._next)
        {
            if (!n1) return !n2;
            if (!n2 || n1._payload != n2._payload) return false;
        }
    }

/**
Defines the container's primary range, which embodies a forward range.
     */
    struct Range
    {
        private Node * _head;
        private this(Node * p) { _head = p; }
        /// Forward range primitives.
        bool empty() const { return !_head; }
        /// ditto
        @property Range save() { return this; }
        /// ditto
        @property T front() { return _head._payload; }
        /// ditto
        @property void front(T value)
        {
            enforce(_head);
            _head._payload = value;
        }
        /// ditto
        void popFront()
        {
            enforce(_head);
            _head = _head._next;
        }

        T moveFront()
        {
            enforce(_head);
            return move(_head._payload);
        }
    }

    unittest
    {
        static assert(isForwardRange!Range);
    }

/**
Property returning $(D true) if and only if the container has no
elements.

Complexity: $(BIGOH 1)
     */
    @property bool empty() const
    {
        return _root is null;
    }

/**
Duplicates the container. The elements themselves are not transitively
duplicated.

Complexity: $(BIGOH n).
     */
    @property SList dup()
    {
        return SList(this[]);
    }

/**
Returns a range that iterates over all elements of the container, in
forward order.

Complexity: $(BIGOH 1)
     */
    Range opSlice()
    {
        return Range(_root);
    }

/**
Forward to $(D opSlice().front).

Complexity: $(BIGOH 1)
     */
    @property T front()
    {
        enforce(_root);
        return _root._payload;
    }

/**
Forward to $(D opSlice().front(value)).

Complexity: $(BIGOH 1)
     */
    @property void front(T value)
    {
        enforce(_root);
        _root._payload = value;
    }

    unittest
    {
        auto s = SList!int(1, 2, 3);
        s.front = 42;
        assert(s == SList!int(42, 2, 3));
    }

/**
Returns a new $(D SList) that's the concatenation of $(D this) and its
argument. $(D opBinaryRight) is only defined if $(D Stuff) does not
define $(D opBinary).
     */
    SList opBinary(string op, Stuff)(Stuff rhs)
    if (op == "~" && is(typeof(SList(rhs))))
    {
        auto toAdd = SList(rhs);
        static if (is(Stuff == SList))
        {
            toAdd = toAdd.dup;
        }
        if (empty) return toAdd;
        // TODO: optimize
        auto result = dup;
        auto n = findLastNode(result._root);
        n._next = toAdd._root;
        return result;
    }

/**
Removes all contents from the $(D SList).

Postcondition: $(D empty)

Complexity: $(BIGOH 1)
     */
    void clear()
    {
        _root = null;
    }

/**
Inserts $(D stuff) to the front of the container. $(D stuff) can be a
value convertible to $(D T) or a range of objects convertible to $(D
T). The stable version behaves the same, but guarantees that ranges
iterating over the container are never invalidated.

Returns: The number of elements inserted

Complexity: $(BIGOH log(n))
     */
    size_t insertFront(Stuff)(Stuff stuff)
    if (isInputRange!Stuff && isImplicitlyConvertible!(ElementType!Stuff, T))
    {
        size_t result;
        Node * n, newRoot;
        foreach (item; stuff)
        {
            auto newNode = new Node(item, null);
            (newRoot ? n._next : newRoot) = newNode;
            n = newNode;
            ++result;
        }
        if (!n) return 0;
        // Last node points to the old root
        n._next = _root;
        _root = newRoot;
        return result;
    }

    /// ditto
    size_t insertFront(Stuff)(Stuff stuff)
    if (isImplicitlyConvertible!(Stuff, T))
    {
        auto newRoot = new Node(stuff, _root);
        _root = newRoot;
        return 1;
    }

/// ditto
    alias insertFront insert;

/// ditto
    alias insert stableInsert;

    /// ditto
    alias insertFront stableInsertFront;

/**
Picks one value from the front of the container, removes it from the
container, and returns it.

Precondition: $(D !empty)

Returns: The element removed.

Complexity: $(BIGOH 1).
     */
    T removeAny()
    {
        enforce(!empty);
        auto result = move(_root._payload);
        _root = _root._next;
        return result;
    }
    /// ditto
    alias removeAny stableRemoveAny;

/**
Removes the value at the front of the container. The stable version
behaves the same, but guarantees that ranges iterating over the
container are never invalidated.

Precondition: $(D !empty)

Complexity: $(BIGOH 1).
     */
    void removeFront()
    {
        enforce(_root);
        _root = _root._next;
    }

    /// ditto
    alias removeFront stableRemoveFront;

/**
Removes $(D howMany) values at the front or back of the
container. Unlike the unparameterized versions above, these functions
do not throw if they could not remove $(D howMany) elements. Instead,
if $(D howMany > n), all elements are removed. The returned value is
the effective number of elements removed. The stable version behaves
the same, but guarantees that ranges iterating over the container are
never invalidated.

Returns: The number of elements removed

Complexity: $(BIGOH howMany * log(n)).
     */
    size_t removeFront(size_t howMany)
    {
        size_t result;
        while (_root && result < howMany)
        {
            _root = _root._next;
            ++result;
        }
        return result;
    }

    /// ditto
    alias removeFront stableRemoveFront;

/**
Inserts $(D stuff) after range $(D r), which must be a range
previously extracted from this container. Given that all ranges for a
list end at the end of the list, this function essentially appends to
the list and uses $(D r) as a potentially fast way to reach the last
node in the list. (Ideally $(D r) is positioned near or at the last
element of the list.)

$(D stuff) can be a value convertible to $(D T) or a range of objects
convertible to $(D T). The stable version behaves the same, but
guarantees that ranges iterating over the container are never
invalidated.

Returns: The number of values inserted.

Complexity: $(BIGOH k + m), where $(D k) is the number of elements in
$(D r) and $(D m) is the length of $(D stuff).
     */

    size_t insertAfter(Stuff)(Range r, Stuff stuff)
    {
        if (!_root)
        {
            enforce(!r._head);
            return insertFront(stuff);
        }
        enforce(r._head);
        auto n = findLastNode(r._head);
        SList tmp;
        auto result = tmp.insertFront(stuff);
        n._next = tmp._root;
        return result;
    }

/**
Similar to $(D insertAfter) above, but accepts a range bounded in
count. This is important for ensuring fast insertions in the middle of
the list.  For fast insertions after a specified position $(D r), use
$(D insertAfter(take(r, 1), stuff)). The complexity of that operation
only depends on the number of elements in $(D stuff).

Precondition: $(D r.original.empty || r.maxLength > 0)

Returns: The number of values inserted.

Complexity: $(BIGOH k + m), where $(D k) is the number of elements in
$(D r) and $(D m) is the length of $(D stuff).
     */
    size_t insertAfter(Stuff)(Take!Range r, Stuff stuff)
    {
        auto orig = r.original;
        if (!orig._head)
        {
            // Inserting after a null range counts as insertion to the
            // front
            return insertFront(stuff);
        }
        enforce(!r.empty);
        // Find the last valid element in the range
        foreach (i; 1 .. r.maxLength)
        {
            if (!orig._head._next) break;
            orig.popFront();
        }
        // insert here
        SList tmp;
        tmp._root = orig._head._next;
        auto result = tmp.insertFront(stuff);
        orig._head._next = tmp._root;
        return result;
    }

/// ditto
    alias insertAfter stableInsertAfter;

/**
Removes a range from the list in linear time.

Returns: An empty range.

Complexity: $(BIGOH n)
     */
    Range linearRemove(Range r)
    {
        if (!_root)
        {
            enforce(!r._head);
            return this[];
        }
        auto n = findNode(_root, r._head);
        n._next = null;
        return Range(null);
    }

/**
Removes a $(D Take!Range) from the list in linear time.

Returns: A range comprehending the elements after the removed range.

Complexity: $(BIGOH n)
     */
    Range linearRemove(Take!Range r)
    {
        auto orig = r.original;
        // We have something to remove here
        if (orig._head == _root)
        {
            // remove straight from the head of the list
            for (; !orig.empty; orig.popFront())
            {
                removeFront();
            }
            return this[];
        }
        if (!r.maxLength)
        {
            // Nothing to remove, return the range itself
            return orig;
        }
        // Remove from somewhere in the middle of the list
        enforce(_root);
        auto n1 = findNode(_root, orig._head);
        auto n2 = findLastNode(orig._head, r.maxLength);
        n1._next = n2._next;
        return Range(n1._next);
    }

/// ditto
    alias linearRemove stableLinearRemove;
}

unittest
{
    auto s = make!(SList!int)(1, 2, 3);
    auto n = s.findLastNode(s._root);
    assert(n && n._payload == 3);
}

unittest
{
    auto s = SList!int(1, 2, 5, 10);
    assert(walkLength(s[]) == 4);
}

unittest
{
    auto src = take([0, 1, 2, 3], 3);
    auto s = SList!int(src);
    assert(s == SList!int(0, 1, 2));
}

unittest
{
    auto a = SList!int(1, 2, 3);
    auto b = SList!int(4, 5, 6);
    // @@@BUG@@@ in compiler
    //auto c = a ~ b;
    auto d = [ 4, 5, 6 ];
    auto e = a ~ d;
    assert(e == SList!int(1, 2, 3, 4, 5, 6));
}

unittest
{
    auto a = SList!int(1, 2, 3);
    auto c = a ~ 4;
    assert(c == SList!int(1, 2, 3, 4));
}

unittest
{
    auto s = SList!int(1, 2, 3, 4);
    s.insertFront([ 42, 43 ]);
    assert(s == SList!int(42, 43, 1, 2, 3, 4));
}

unittest
{
    auto s = SList!int(1, 2, 3);
    assert(s.removeAny() == 1);
    assert(s == SList!int(2, 3));
    assert(s.stableRemoveAny() == 2);
    assert(s == SList!int(3));
}

unittest
{
    auto s = SList!int(1, 2, 3);
    s.removeFront();
    assert(equal(s[], [2, 3]));
    s.stableRemoveFront();
    assert(equal(s[], [3]));
}

unittest
{
    auto s = SList!int(1, 2, 3, 4, 5, 6, 7);
    assert(s.removeFront(3) == 3);
    assert(s == SList!int(4, 5, 6, 7));
}

unittest
{
    auto a = SList!int(1, 2, 3);
    auto b = SList!int(1, 2, 3);
    assert(a.insertAfter(a[], b[]) == 3);
}

unittest
{
    auto s = SList!int(1, 2, 3, 4);
    auto r = take(s[], 2);
    assert(s.insertAfter(r, 5) == 1);
    assert(s == SList!int(1, 2, 5, 3, 4));
}

unittest
{
    auto s = SList!int(1, 2, 3, 4, 5);
    auto r = s[];
    popFrontN(r, 3);
    auto r1 = s.linearRemove(r);
    assert(s == SList!int(1, 2, 3));
    assert(r1.empty);
}

unittest
{
    auto s = SList!int(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
    auto r = s[];
    popFrontN(r, 3);
    auto r1 = take(r, 4);
    assert(equal(r1, [4, 5, 6, 7]));
    auto r2 = s.linearRemove(r1);
    assert(s == SList!int(1, 2, 3, 8, 9, 10));
    assert(equal(r2, [8, 9, 10]));
}


unittest
{
    auto lst = SList!int(1, 5, 42, 9);
    assert(!lst.empty);
    assert(lst.front == 1);
    assert(walkLength(lst[]) == 4);

    auto lst2 = lst ~ [ 1, 2, 3 ];
    assert(walkLength(lst2[]) == 7);

    auto lst3 = lst ~ [ 7 ];
    assert(walkLength(lst3[]) == 5);
}

unittest
{
    auto s = make!(SList!int)(1, 2, 3);
}

/**
Array type with deterministic control of memory. The memory allocated
for the array is reclaimed as soon as possible; there is no reliance
on the garbage collector. $(D Array) uses $(D malloc) and $(D free)
for managing its own memory.
 */
struct Array(T) if (!is(T : const(bool)))
{
    // This structure is not copyable.
    private struct Payload
    {
        size_t _capacity;
        T[] _payload;

        // Convenience constructor
        this(T[] p) { _capacity = p.length; _payload = p; }

        // Destructor releases array memory
        ~this()
        {
            foreach (ref e; _payload) .clear(e);
            static if (hasIndirections!T)
                GC.removeRange(_payload.ptr);
            free(_payload.ptr);
        }

        this(this)
        {
            assert(0);
        }

        void opAssign(Array!(T).Payload rhs)
        {
            assert(false);
        }

        // Duplicate data
        // @property Payload dup()
        // {
        //     Payload result;
        //     result._payload = _payload.dup;
        //     // Conservatively assume initial capacity == length
        //     result._capacity = result._payload.length;
        //     return result;
        // }

        // length
        @property size_t length() const
        {
            return _payload.length;
        }

        // length
        @property void length(size_t newLength)
        {
            if (length >= newLength)
            {
                // shorten
                static if (is(T == struct) && hasElaborateDestructor!T)
                {
                    foreach (ref e; _payload.ptr[newLength .. _payload.length])
                    {
                        clear(e);
                    }
                }
                _payload = _payload.ptr[0 .. newLength];
                return;
            }
            // enlarge
            auto startEmplace = length;
            _payload = (cast(T*) realloc(_payload.ptr,
                            T.sizeof * newLength))[0 .. newLength];
            initializeAll(_payload.ptr[startEmplace .. length]);
        }

        // capacity
        @property size_t capacity() const
        {
            return _capacity;
        }

        // reserve
        void reserve(size_t elements)
        {
            if (elements <= capacity) return;
            immutable sz = elements * T.sizeof;
            static if (hasIndirections!T)       // should use hasPointers instead
            {
                /* Because of the transactional nature of this
                 * relative to the garbage collector, ensure no
                 * threading bugs by using malloc/copy/free rather
                 * than realloc.
                 */
                immutable oldLength = length;
                auto newPayload =
                    enforce((cast(T*) malloc(sz))[0 .. oldLength]);
                // copy old data over to new array
                newPayload[] = _payload[];
                // Zero out unused capacity to prevent gc from seeing
                // false pointers
                memset(newPayload.ptr + oldLength,
                        0,
                        (elements - oldLength) * T.sizeof);
                GC.addRange(newPayload.ptr, sz);
                GC.removeRange(_data._payload.ptr);
                free(_data._payload.ptr);
                _data._payload = newPayload;
            }
            else
            {
                /* These can't have pointers, so no need to zero
                 * unused region
                 */
                auto newPayload =
                    enforce(cast(T*) realloc(_payload.ptr, sz))[0 .. length];
                _payload = newPayload;
            }
            _capacity = elements;
        }

        // Insert one item
        size_t insertBack(Stuff)(Stuff stuff)
        if (isImplicitlyConvertible!(Stuff, T))
        {
            if (_capacity == length)
            {
                reserve(1 + capacity * 3 / 2);
            }
            assert(capacity > length && _payload.ptr);
            emplace!T((cast(void*) (_payload.ptr + _payload.length))
                    [0 .. T.sizeof],
                    stuff);
            _payload = _payload.ptr[0 .. _payload.length + 1];
            return 1;
        }

        /// Insert a range of items
        size_t insertBack(Stuff)(Stuff stuff)
        if (isInputRange!Stuff && isImplicitlyConvertible!(ElementType!Stuff, T))
        {
            static if (hasLength!Stuff)
            {
                immutable oldLength = length;
                reserve(oldLength + stuff.length);
            }
            size_t result;
            foreach (item; stuff)
            {
                insertBack(item);
                ++result;
            }
            static if (hasLength!Stuff)
            {
                assert(length == oldLength + stuff.length);
            }
            return result;
        }
    }
    private alias RefCounted!(Payload, RefCountedAutoInitialize.no) Data;
    private Data _data;

    this(U)(U[] values...) if (isImplicitlyConvertible!(U, T))
    {
        auto p = malloc(T.sizeof * values.length);
        if (hasIndirections!T && p)
        {
            GC.addRange(p, T.sizeof * values.length);
        }
        foreach (i, e; values)
        {
            emplace!T(p[i * T.sizeof .. (i + 1) * T.sizeof], e);
            assert((cast(T*) p)[i] == e);
        }
        _data.RefCounted.initialize((cast(T*) p)[0 .. values.length]);
    }

/**
Comparison for equality.
     */
    bool opEquals(ref const Array rhs) const
    {
        if (empty) return rhs.empty;
        if (rhs.empty) return false;
        return _data._payload == rhs._data._payload;
    }

/**
Defines the container's primary range, which is a random-access range.
     */
    struct Range
    {
        private Array _outer;
        private size_t _a, _b;

        this(Array data, size_t a, size_t b)
        {
            _outer = data;
            _a = a;
            _b = b;
        }

        @property bool empty() const
        {
            assert(_outer.length >= _b);
            return _a >= _b;
        }

        @property Range save()
        {
            return this;
        }

        @property T front()
        {
            enforce(!empty);
            return _outer[_a];
        }

        @property void front(T value)
        {
            enforce(!empty);
            _outer[_a] = move(value);
        }

        void popFront()
        {
            enforce(!empty);
            ++_a;
        }

        T moveFront()
        {
            enforce(!empty);
            return move(_outer._data._payload[_a]);
        }

        T moveBack()
        {
            enforce(!empty);
            return move(_outer._data._payload[_b - 1]);
        }

        T moveAt(size_t i)
        {
            i += _a;
            enforce(i < _b && !empty);
            return move(_outer._data._payload[_a + i]);
        }

        T opIndex(size_t i)
        {
            i += _a;
            enforce(i < _b && _b <= _outer.length);
            return _outer[i];
        }

        void opIndexAssign(T value, size_t i)
        {
            i += _a;
            enforce(i < _b && _b <= _outer.length);
            _outer[i] = value;
        }

        void opIndexOpAssign(string op)(T value, size_t i)
        {
            enforce(_outer && _a + i < _b && _b <= _outer._payload.length);
            mixin("_outer._payload.ptr[_a + i] "~op~"= value;");
        }
    }

/**
Property returning $(D true) if and only if the container has no
elements.

Complexity: $(BIGOH 1)
     */
    @property bool empty() const
    {
        return !_data.RefCounted.isInitialized || _data._payload.empty;
    }

/**
Duplicates the container. The elements themselves are not transitively
duplicated.

Complexity: $(BIGOH n).
     */
    @property Array dup()
    {
        if (!_data.RefCounted.isInitialized) return this;
        return Array(_data._payload);
    }

/**
Returns the number of elements in the container.

Complexity: $(BIGOH 1).
     */
    @property size_t length() const
    {
        return _data.RefCounted.isInitialized ? _data._payload.length : 0;
    }

/**
Returns the maximum number of elements the container can store without
   (a) allocating memory, (b) invalidating iterators upon insertion.

Complexity: $(BIGOH 1)
     */
    @property size_t capacity()
    {
        return _data.RefCounted.isInitialized ? _data._capacity : 0;
    }

/**
Ensures sufficient capacity to accommodate $(D e) elements.

Postcondition: $(D capacity >= e)

Complexity: $(BIGOH 1)
     */
    void reserve(size_t elements)
    {
        if (!_data.RefCounted.isInitialized)
        {
            if (!elements) return;
            immutable sz = elements * T.sizeof;
            auto p = enforce(malloc(sz));
            static if (hasIndirections!T)
            {
                GC.addRange(p, sz);
            }
            _data.RefCounted.initialize(cast(T[]) p[0 .. 0]);
            _data._capacity = elements;
        }
        else
        {
            _data.reserve(elements);
        }
    }

/**
Returns a range that iterates over elements of the container, in
forward order.

Complexity: $(BIGOH 1)
     */
    Range opSlice()
    {
        // Workaround for bug 4356
        Array copy;
        copy._data = this._data;
        return Range(copy, 0, length);
    }

/**
Returns a range that iterates over elements of the container from
index $(D a) up to (excluding) index $(D b).

Precondition: $(D a <= b && b <= length)

Complexity: $(BIGOH 1)
     */
    Range opSlice(size_t a, size_t b)
    {
        enforce(a <= b && b <= length);
        // Workaround for bug 4356
        Array copy;
        copy._data = this._data;
        return Range(copy, a, b);
    }

/**
@@@BUG@@@ This doesn't work yet
     */
    size_t opDollar() const
    {
        return length;
    }

/**
Forward to $(D opSlice().front) and $(D opSlice().back), respectively.

Precondition: $(D !empty)

Complexity: $(BIGOH 1)
     */
    @property T front()
    {
        enforce(!empty);
        return *_data._payload.ptr;
    }

/// ditto
    @property void front(T value)
    {
        enforce(!empty);
        *_data._payload.ptr = value;
    }

/// ditto
    @property T back()
    {
        enforce(!empty);
        return _data._payload[$ - 1];
    }

/// ditto
    @property void back(T value)
    {
        enforce(!empty);
        _data._payload[$ - 1] = value;
    }

/**
Indexing operators yield or modify the value at a specified index.

Precondition: $(D i < length)

Complexity: $(BIGOH 1)
     */
    T opIndex(size_t i)
    {
        enforce(_data.RefCounted.isInitialized);
        return _data._payload[i];
    }

    /// ditto
    void opIndexAssign(T value, size_t i)
    {
        enforce(_data.RefCounted.isInitialized);
        _data._payload[i] = value;
    }

/// ditto
    void opIndexOpAssign(string op)(T value, size_t i)
    {
        mixin("_data._payload[i] "~op~"= value;");
    }

/**
Returns a new container that's the concatenation of $(D this) and its
argument. $(D opBinaryRight) is only defined if $(D Stuff) does not
define $(D opBinary).

Complexity: $(BIGOH n + m), where m is the number of elements in $(D
stuff)
     */
    Array opBinary(string op, Stuff)(Stuff stuff) if (op == "~")
    {
        // TODO: optimize
        Array result;
        // @@@BUG@@ result ~= this[] doesn't work
        auto r = this[];
        result ~= r;
        assert(result.length == length);
        result ~= stuff[];
        return result;
    }

    /**
       Forwards to $(D insertBack(stuff)).
     */
    void opOpAssign(string op, Stuff)(Stuff stuff) if (op == "~")
    {
        static if (is(typeof(stuff[])))
        {
            insertBack(stuff[]);
        }
        else
        {
            insertBack(stuff);
        }
    }

/**
Removes all contents from the container. The container decides how $(D
capacity) is affected.

Postcondition: $(D empty)

Complexity: $(BIGOH n)
     */
    void clear()
    {
        .clear(_data);
    }

/**
Sets the number of elements in the container to $(D newSize). If $(D
newSize) is greater than $(D length), the added elements are added to
unspecified positions in the container and initialized with $(D
T.init).

Complexity: $(BIGOH abs(n - newLength))

Postcondition: $(D length == newLength)
     */
    @property void length(size_t newLength)
    {
        _data.RefCounted.ensureInitialized();
        _data.length = newLength;
    }

/**
Picks one value in an unspecified position in the container, removes
it from the container, and returns it. Implementations should pick the
value that's the most advantageous for the container, but document the
exact behavior. The stable version behaves the same, but guarantees
that ranges iterating over the container are never invalidated.

Precondition: $(D !empty)

Returns: The element removed.

Complexity: $(BIGOH log(n)).
     */
    T removeAny()
    {
        auto result = back;
        removeBack();
        return result;
    }
    /// ditto
    alias removeAny stableRemoveAny;

/**
Inserts $(D value) to the front or back of the container. $(D stuff)
can be a value convertible to $(D T) or a range of objects convertible
to $(D T). The stable version behaves the same, but guarantees that
ranges iterating over the container are never invalidated.

Returns: The number of elements inserted

Complexity: $(BIGOH m * log(n)), where $(D m) is the number of
elements in $(D stuff)
     */
    size_t insertBack(Stuff)(Stuff stuff)
    if (isImplicitlyConvertible!(Stuff, T) ||
            isInputRange!Stuff && isImplicitlyConvertible!(ElementType!Stuff, T))
    {
        _data.RefCounted.ensureInitialized();
        return _data.insertBack(stuff);
    }
/// ditto
    alias insertBack insert;

/**
Removes the value at the back of the container. The stable version
behaves the same, but guarantees that ranges iterating over the
container are never invalidated.

Precondition: $(D !empty)

Complexity: $(BIGOH log(n)).
     */
    void removeBack()
    {
        enforce(!empty);
        static if (is(T == struct))
        {
            // Destroy this guy
            clear(_data._payload[$ - 1]);
        }
        _data._payload = _data._payload[0 .. $ - 1];
    }
/// ditto
    alias removeBack stableRemoveBack;

/**
Removes $(D howMany) values at the front or back of the
container. Unlike the unparameterized versions above, these functions
do not throw if they could not remove $(D howMany) elements. Instead,
if $(D howMany > n), all elements are removed. The returned value is
the effective number of elements removed. The stable version behaves
the same, but guarantees that ranges iterating over the container are
never invalidated.

Returns: The number of elements removed

Complexity: $(BIGOH howMany).
     */
    size_t removeBack(size_t howMany)
    {
        if (howMany > length) howMany = length;
        static if (is(T == struct))
        {
            // Destroy this guy
            foreach (ref e; _data._payload[$ - howMany .. $])
            {
                clear(e);
            }
        }
        _data._payload = _data._payload[0 .. $ - howMany];
        return howMany;
    }
    /// ditto
    alias removeBack stableRemoveBack;

/**
Inserts $(D stuff) before, after, or instead range $(D r), which must
be a valid range previously extracted from this container. $(D stuff)
can be a value convertible to $(D T) or a range of objects convertible
to $(D T). The stable version behaves the same, but guarantees that
ranges iterating over the container are never invalidated.

Returns: The number of values inserted.

Complexity: $(BIGOH n + m), where $(D m) is the length of $(D stuff)
     */
    size_t insertBefore(Stuff)(Range r, Stuff stuff)
    if (isImplicitlyConvertible!(Stuff, T))
    {
        enforce(r._outer._data == _data && r._a < length);
        reserve(length + 1);
        assert(_data.RefCounted.isInitialized);
        // Move elements over by one slot
        memmove(_data._payload.ptr + r._a + 1,
                _data._payload.ptr + r._a,
                T.sizeof * (length - r._a));
        emplace!T((cast(void*) (_data._payload.ptr + r._a))[0 .. T.sizeof],
                stuff);
        _data._payload = _data._payload.ptr[0 .. _data._payload.length + 1];
        return 1;
    }

/// ditto
    size_t insertBefore(Stuff)(Range r, Stuff stuff)
    if (isInputRange!Stuff && isImplicitlyConvertible!(ElementType!Stuff, T))
    {
        enforce(r._outer._data == _data && r._a <= length);
        static if (isForwardRange!Stuff)
        {
            // Can find the length in advance
            auto extra = walkLength(stuff);
            if (!extra) return 0;
            reserve(length + extra);
            assert(_data.RefCounted.isInitialized);
            // Move elements over by extra slots
            memmove(_data._payload.ptr + r._a + extra,
                    _data._payload.ptr + r._a,
                    T.sizeof * (length - r._a));
            foreach (p; _data._payload.ptr + r._a ..
                    _data._payload.ptr + r._a + extra)
            {
                emplace!T((cast(void*) p)[0 .. T.sizeof], stuff.front);
                stuff.popFront();
            }
            _data._payload =
                _data._payload.ptr[0 .. _data._payload.length + extra];
            return extra;
        }
        else
        {
            enforce(_data);
            immutable offset = r._a;
            enforce(offset <= length);
            auto result = insertBack(stuff);
            bringToFront(this[offset .. length - result],
                    this[length - result .. length]);
            return result;
        }
    }

    /// ditto
    size_t insertAfter(Stuff)(Range r, Stuff stuff)
    {
        // TODO: optimize
        enforce(_data);
        immutable offset = r.ptr + r.length - _data._payload.ptr;
        enforce(offset <= length);
        auto result = insertBack(stuff);
        bringToFront(this[offset .. length - result],
                this[length - result .. length]);
        return result;
    }

/// ditto
    size_t replace(Stuff)(Range r, Stuff stuff)
    if (isInputRange!Stuff && isImplicitlyConvertible!(ElementType!Stuff, T))
    {
        enforce(_data);
        immutable offset = r.ptr - _data._payload.ptr;
        enforce(offset <= length);
        size_t result;
        for (; !stuff.empty; stuff.popFront())
        {
            if (r.empty)
            {
                // append the rest
                return result + insertBack(stuff);
            }
            r.front = stuff.front;
            r.popFront();
            ++result;
        }
        // Remove remaining stuff in r
        remove(r);
        return result;
    }

/// ditto
    size_t replace(Stuff)(Range r, Stuff stuff)
    if (isImplicitlyConvertible!(Stuff, T))
    {
        if (r.empty)
        {
            insertBefore(r, stuff);
        }
        else
        {
            r.front = stuff;
            r.popFront();
            remove(r);
        }
        return 1;
    }

/**
Removes all elements belonging to $(D r), which must be a range
obtained originally from this container. The stable version behaves
the same, but guarantees that ranges iterating over the container are
never invalidated.

Returns: A range spanning the remaining elements in the container that
initially were right after $(D r).

Complexity: $(BIGOH n - m), where $(D m) is the number of elements in
$(D r)
     */
    Range linearRemove(Range r)
    {
        enforce(_data.RefCounted.isInitialized);
        enforce(r._a <= r._b && r._b <= length);
        immutable offset1 = r._a;
        immutable offset2 = r._b;
        immutable tailLength = length - offset2;
        // Use copy here, not a[] = b[] because the ranges may overlap
        copy(this[offset2 .. length], this[offset1 .. offset1 + tailLength]);
        length = offset1 + tailLength;
        return this[length - tailLength .. length];
    }

    /// ditto
    alias remove stableLinearRemove;

}

// unittest
// {
//     Array!int a;
//     assert(a.empty);
// }

unittest
{
    Array!int a = Array!int(1, 2, 3);
    //a._data._refCountedDebug = true;
    auto b = a.dup;
    assert(b == Array!int(1, 2, 3));
    b.front = 42;
    assert(b == Array!int(42, 2, 3));
    assert(a == Array!int(1, 2, 3));
}

unittest
{
    auto a = Array!int(1, 2, 3);
    assert(a.length == 3);
}

unittest
{
    Array!int a;
    a.reserve(1000);
    assert(a.length == 0);
    assert(a.empty);
    assert(a.capacity >= 1000);
    auto p = a._data._payload.ptr;
    foreach (i; 0 .. 1000)
    {
        a.insertBack(i);
    }
    assert(p == a._data._payload.ptr);
}

unittest
{
    auto a = Array!int(1, 2, 3);
    a[1] *= 42;
    assert(a[1] == 84);
}

unittest
{
    auto a = Array!int(1, 2, 3);
    auto b = Array!int(11, 12, 13);
    auto c = a ~ b;
    //foreach (e; c) writeln(e);
    assert(c == Array!int(1, 2, 3, 11, 12, 13));
    //assert(a ~ b[] == Array!int(1, 2, 3, 11, 12, 13));
}

unittest
{
    auto a = Array!int(1, 2, 3);
    auto b = Array!int(11, 12, 13);
    a ~= b;
    assert(a == Array!int(1, 2, 3, 11, 12, 13));
}

unittest
{
    auto a = Array!int(1, 2, 3, 4);
    assert(a.removeAny() == 4);
    assert(a == Array!int(1, 2, 3));
}

unittest
{
    auto a = Array!int(1, 2, 3, 4, 5);
    auto r = a[2 .. a.length];
    assert(a.insertBefore(r, 42) == 1);
    assert(a == Array!int(1, 2, 42, 3, 4, 5));
    r = a[2 .. 2];
    assert(a.insertBefore(r, [8, 9]) == 2);
    assert(a == Array!int(1, 2, 8, 9, 42, 3, 4, 5));
}

unittest
{
    auto a = Array!int(0, 1, 2, 3, 4, 5, 6, 7, 8);
    a.linearRemove(a[4 .. 6]);
    auto b = Array!int(0, 1, 2, 3, 6, 7, 8);
    //writeln(a.length);
    //foreach (e; a) writeln(e);
    assert(a == Array!int(0, 1, 2, 3, 6, 7, 8));
}

// BinaryHeap
/**
Implements a $(WEB en.wikipedia.org/wiki/Binary_heap, binary heap)
container on top of a given random-access range type (usually $(D
T[])) or a random-access container type (usually $(D Array!T)). The
documentation of $(D BinaryHeap) will refer to the underlying range or
container as the $(I store) of the heap.

The binary heap induces structure over the underlying store such that
accessing the largest element (by using the $(D front) property) is a
$(BIGOH 1) operation and extracting it (by using the $(D
removeFront()) method) is done fast in $(BIGOH log n) time.

If $(D less) is the less-than operator, which is the default option,
then $(D BinaryHeap) defines a so-called max-heap that optimizes
extraction of the $(I largest) elements. To define a min-heap,
instantiate BinaryHeap with $(D "a > b") as its predicate.

Simply extracting elements from a $(D BinaryHeap) container is
tantamount to lazily fetching elements of $(D Store) in descending
order. Extracting elements from the $(D BinaryHeap) to completion
leaves the underlying store sorted in ascending order but, again,
yields elements in descending order.

If $(D Store) is a range, the $(D BinaryHeap) cannot grow beyond the
size of that range. If $(D Store) is a container that supports $(D
insertBack), the $(D BinaryHeap) may grow by adding elements to the
container.

Example:
----
// Example from "Introduction to Algorithms" Cormen et al, p 146
int[] a = [ 4, 1, 3, 2, 16, 9, 10, 14, 8, 7 ];
auto h = heapify(a);
// largest element
assert(h.front == 16);
// a has the heap property
assert(equal(a, [ 16, 14, 10, 9, 8, 7, 4, 3, 2, 1 ]));
----
     */
struct BinaryHeap(Store, alias less = "a < b")
if (isRandomAccessRange!(Store) || isRandomAccessRange!(typeof(Store.init[])))
{
// Really weird @@BUG@@: if you comment out the "private:" label below,
// std.algorithm can't unittest anymore
//private:

    // The payload includes the support store and the effective length
    private RefCounted!(Tuple!(Store, "_store", size_t, "_length"),
                       RefCountedAutoInitialize.no) _payload;
    // Comparison predicate
    private alias binaryFun!(less) comp;
    // Convenience accessors
    private @property ref Store _store()
    {
        assert(_payload.RefCounted.isInitialized);
        return _payload._store;
    }
    private @property ref size_t _length()
    {
        assert(_payload.RefCounted.isInitialized);
        return _payload._length;
    }

    // Asserts that the heap property is respected.
    private void assertValid()
    {
        debug
        {
            if (!_payload.RefCounted.isInitialized) return;
            if (_length < 2) return;
            for (size_t n = _length - 1; n >= 1; --n)
            {
                auto parentIdx = (n - 1) / 2;
                assert(!comp(_store[parentIdx], _store[n]), text(n));
            }
        }
    }

    // Assuming the element at index i perturbs the heap property in
    // store r, percolates it down the heap such that the heap
    // property is restored.
    private void percolateDown(Store r, size_t i, size_t length)
    {
        for (;;)
        {
            auto left = i * 2 + 1, right = left + 1;
            if (right == length)
            {
                if (comp(r[i], r[left])) swap(r, i, left);
                return;
            }
            if (right > length) return;
            assert(left < length && right < length);
            auto largest = comp(r[i], r[left])
                ? (comp(r[left], r[right]) ? right : left)
                : (comp(r[i], r[right]) ? right : i);
            if (largest == i) return;
            swap(r, i, largest);
            i = largest;
        }
    }

    // @@@BUG@@@: add private here, std.algorithm doesn't unittest anymore
    /*private*/ void pop(Store store)
    {
        assert(!store.empty);
        if (store.length == 1) return;
        auto t1 = moveFront(store[]);
        auto t2 = moveBack(store[]);
        store.front = move(t2);
        store.back = move(t1);
        percolateDown(store, 0, store.length - 1);
    }

    /*private*/ static void swap(Store _store, size_t i, size_t j)
    {
        static if (is(typeof(swap(_store[i], _store[j]))))
        {
            swap(_store[i], _store[j]);
        }
        else static if (is(typeof(_store.moveAt(i))))
        {
            auto t1 = _store.moveAt(i);
            auto t2 = _store.moveAt(j);
            _store[i] = move(t2);
            _store[j] = move(t1);
        }
        else // assume it's a container and access its range with []
        {
            auto t1 = _store[].moveAt(i);
            auto t2 = _store[].moveAt(j);
            _store[i] = move(t2);
            _store[j] = move(t1);
        }
    }

public:

    /**
       Converts the store $(D s) into a heap. If $(D initialSize) is
       specified, only the first $(D initialSize) elements in $(D s)
       are transformed into a heap, after which the heap can grow up
       to $(D r.length) (if $(D Store) is a range) or indefinitely (if
       $(D Store) is a container with $(D insertBack)). Performs
       $(BIGOH min(r.length, initialSize)) evaluations of $(D less).
     */
    this(Store s, size_t initialSize = size_t.max)
    {
        acquire(s, initialSize);
    }

/**
Takes ownership of a store. After this, manipulating $(D s) may make
the heap work incorrectly.
     */
    void acquire(Store s, size_t initialSize = size_t.max)
    {
        _payload.RefCounted.ensureInitialized();
        _store() = move(s);
        _length() = min(_store.length, initialSize);
        if (_length < 2) return;
        for (auto i = (_length - 2) / 2; ; )
        {
            this.percolateDown(_store, i, _length);
            if (i-- == 0) break;
        }
        assertValid;
    }

/**
Takes ownership of a store assuming it already was organized as a
heap.
     */
    void assume(Store s, size_t initialSize = size_t.max)
    {
        _payload.RefCounted.ensureInitialized();
        _store() = s;
        _length() = min(_store.length, initialSize);
        assertValid;
    }

/**
Clears the heap. Returns the portion of the store from $(D 0) up to
$(D length), which satisfies the $(LUCKY heap property).
     */
    auto release()
    {
        if (!_payload.RefCounted.isInitialized)
        {
            return typeof(_store[0 .. _length]).init;
        }
        assertValid();
        auto result = _store[0 .. _length];
        _payload = _payload.init;
        return result;
    }

/**
Returns $(D true) if the heap is _empty, $(D false) otherwise.
     */
    @property bool empty()
    {
        return !length;
    }

/**
Returns a duplicate of the heap. The underlying store must also
support a $(D dup) method.
     */
    @property BinaryHeap dup()
    {
        BinaryHeap result;
        if (!_payload.RefCounted.isInitialized) return result;
        result.assume(_store.dup, length);
        return result;
    }

/**
Returns the _length of the heap.
     */
    @property size_t length()
    {
        return _payload.RefCounted.isInitialized ? _length : 0;
    }

/**
Returns the _capacity of the heap, which is the length of the
underlying store (if the store is a range) or the _capacity of the
underlying store (if the store is a container).
     */
    @property size_t capacity()
    {
        if (!_payload.RefCounted.isInitialized) return 0;
        static if (is(typeof(_store.capacity) : size_t))
        {
            return _store.capacity;
        }
        else
        {
            return _store.length;
        }
    }

/**
Returns a copy of the _front of the heap, which is the largest element
according to $(D less).
     */
    @property ElementType!Store front()
    {
        enforce(!empty);
        return _store.front;
    }

/**
Clears the heap by detaching it from the underlying store.
     */
    void clear()
    {
        _payload = _payload.init;
    }

/**
Inserts $(D value) into the store. If the underlying store is a range
and $(D length == capacity), throws an exception.
     */
    size_t insert(ElementType!Store value)
    {
        static if (is(_store.insertBack(value)))
        {
            _payload.RefCounted.ensureInitialized();
            if (length == _store.length)
            {
                // reallocate
                _store.insertBack(value);
            }
            else
            {
                // no reallocation
                _store[_length] = value;
            }
        }
        else
        {
            // can't grow
            enforce(length < _store.length,
                    "Cannot grow a heap created over a range");
            _store[_length] = value;
        }

        // sink down the element
        for (size_t n = _length; n; )
        {
            auto parentIdx = (n - 1) / 2;
            if (!comp(_store[parentIdx], _store[n])) break; // done!
            // must swap and continue
            swap(_store, parentIdx, n);
            n = parentIdx;
        }
        ++_length;
        assertValid();
        return 1;
    }

/**
Removes the largest element from the heap.
     */
    void removeFront()
    {
        enforce(!empty);
        if (_length > 1)
        {
            auto t1 = moveFront(_store[]);
            auto t2 = moveAt(_store[], _length - 1);
            _store.front = move(t2);
            _store[_length - 1] = move(t1);
        }
        --_length;
        percolateDown(_store, 0, _length);
    }

/**
Removes the largest element from the heap and returns a copy of
it. The element still resides in the heap's store. For performance
reasons you may want to use $(D removeFront) with heaps of objects
that are expensive to copy.
     */
    ElementType!Store removeAny()
    {
        removeFront();
        return _store[_length];
    }

/**
Replaces the largest element in the store with $(D value).
     */
    void replaceFront(ElementType!Store value)
    {
        // must replace the top
        assert(!empty);
        _store.front = value;
        percolateDown(_store, 0, _length);
        assertValid;
    }

/**
If the heap has room to grow, inserts $(D value) into the store and
returns $(D true). Otherwise, if $(D less(value, front)), calls $(D
replaceFront(value)) and returns again $(D true). Otherwise, leaves
the heap unaffected and returns $(D false). This method is useful in
scenarios where the smallest $(D k) elements of a set of candidates
must be collected.
     */
    bool conditionalInsert(ElementType!Store value)
    {
        _payload.RefCounted.ensureInitialized();
        if (_length < _store.length)
        {
            insert(value);
            return true;
        }
        // must replace the top
        assert(!_store.empty);
        if (!comp(value, _store.front)) return false; // value >= largest
        _store.front = value;
        percolateDown(_store, 0, _length);
        assertValid;
        return true;
    }
}

/**
Convenience function that returns a $(D BinaryHeap!Store) object
initialized with $(D s) and $(D initialSize).
 */
BinaryHeap!Store heapify(Store)(Store s, size_t initialSize = size_t.max)
{
    return BinaryHeap!Store(s, initialSize);
}

unittest
{
    {
        // example from "Introduction to Algorithms" Cormen et al., p 146
        int[] a = [ 4, 1, 3, 2, 16, 9, 10, 14, 8, 7 ];
        auto h = heapify(a);
        assert(h.front == 16);
        assert(a == [ 16, 14, 10, 8, 7, 9, 3, 2, 4, 1 ]);
        auto witness = [ 16, 14, 10, 9, 8, 7, 4, 3, 2, 1 ];
        for (; !h.empty; h.removeFront(), witness.popFront())
        {
            assert(!witness.empty);
            assert(witness.front == h.front);
        }
        assert(witness.empty);
    }
    {
        int[] a = [ 4, 1, 3, 2, 16, 9, 10, 14, 8, 7 ];
        int[] b = new int[a.length];
        BinaryHeap!(int[]) h = BinaryHeap!(int[])(b, 0);
        foreach (e; a)
        {
            h.insert(e);
        }
        assert(b == [ 16, 14, 10, 8, 7, 3, 9, 1, 4, 2 ], text(b));
    }
}

////////////////////////////////////////////////////////////////////////////////
// Array!bool
////////////////////////////////////////////////////////////////////////////////

/**
_Array specialized for $(D bool). Packs together values efficiently by
allocating one bit per element.
 */
struct Array(T) if (is(T == bool))
{
    static immutable uint bitsPerWord = size_t.sizeof * 8;
    private alias Tuple!(Array!(size_t).Payload, "_backend", ulong, "_length")
    Data;
    private RefCounted!(Data, RefCountedAutoInitialize.no) _store;

    private ref size_t[] data()
    {
        assert(_store.RefCounted.isInitialized);
        return _store._backend._payload;
    }

    private ref size_t dataCapacity()
    {
        return _store._backend._capacity;
    }

    /**
       Defines the container's primary range.
     */
    struct Range
    {
        private Array!bool _outer;
        private ulong _a, _b;
        /// Range primitives
        @property Range save()
        {
            version (bug4437)
            {
                return this;
            }
            else
            {
                auto copy = this;
                return copy;
            }
        }
        /// Ditto
        @property bool empty()
        {
            return _a >= _b || _outer.length < _b;
        }
        /// Ditto
        @property T front()
        {
            enforce(!empty);
            return _outer[_a];
        }
        /// Ditto
        @property void front(bool value)
        {
            enforce(!empty);
            _outer[_a] = value;
        }
        /// Ditto
        T moveFront()
        {
            enforce(!empty);
            return _outer.moveAt(_a);
        }
        /// Ditto
        void popFront()
        {
            enforce(!empty);
            ++_a;
        }
        /// Ditto
        @property T back()
        {
            enforce(!empty);
            return _outer[_b - 1];
        }
        /// Ditto
        T moveBack()
        {
            enforce(!empty);
            return _outer.moveAt(_b - 1);
        }
        /// Ditto
        void popBack()
        {
            enforce(!empty);
            --_b;
        }
        /// Ditto
        T opIndex(size_t i)
        {
            return _outer[_a + i];
        }
        /// Ditto
        void opIndexAssign(T value, uint i)
        {
            _outer[_a + i] = value;
        }
        /// Ditto
        T moveAt(size_t i)
        {
            return _outer.moveAt(_a + i);
        }
        /// Ditto
        @property ulong length() const
        {
            assert(_a <= _b);
            return _b - _a;
        }
    }

    /**
       Property returning $(D true) if and only if the container has
       no elements.

       Complexity: $(BIGOH 1)
     */
    @property bool empty()
    {
        return !length;
    }

    unittest
    {
        Array!bool a;
        //a._store._refCountedDebug = true;
        assert(a.empty);
        a.insertBack(false);
        assert(!a.empty);
    }

    /**
       Returns a duplicate of the container. The elements themselves
       are not transitively duplicated.

       Complexity: $(BIGOH n).
     */
    @property Array!bool dup()
    {
        Array!bool result;
        result.insertBack(this[]);
        return result;
    }

    unittest
    {
        Array!bool a;
        assert(a.empty);
        auto b = a.dup;
        assert(b.empty);
        a.insertBack(true);
        assert(b.empty);
    }

    /**
       Returns the number of elements in the container.

       Complexity: $(BIGOH log(n)).
    */
    @property ulong length()
    {
        return _store.RefCounted.isInitialized ? _store._length : 0;
    }

    unittest
    {
        Array!bool a;
        assert(a.length == 0);
        a.insert(true);
        assert(a.length == 1, text(a.length));
    }

    /**
       Returns the maximum number of elements the container can store
       without (a) allocating memory, (b) invalidating iterators upon
       insertion.

       Complexity: $(BIGOH log(n)).
     */
    @property ulong capacity()
    {
        return _store.RefCounted.isInitialized
            ? cast(ulong) bitsPerWord * _store._backend.capacity
            : 0;
    }

    unittest
    {
        Array!bool a;
        assert(a.capacity == 0);
        foreach (i; 0 .. 100)
        {
            a.insert(true);
            assert(a.capacity >= a.length, text(a.capacity));
        }
    }

    /**
       Ensures sufficient capacity to accommodate $(D n) elements.

       Postcondition: $(D capacity >= n)

       Complexity: $(BIGOH log(e - capacity)) if $(D e > capacity),
       otherwise $(BIGOH 1).
     */
    void reserve(ulong e)
    {
        _store.RefCounted.ensureInitialized();
        _store._backend.reserve(to!size_t((e + bitsPerWord - 1) / bitsPerWord));
    }

    unittest
    {
        Array!bool a;
        assert(a.capacity == 0);
        a.reserve(15657);
        assert(a.capacity >= 15657);
    }

    /**
       Returns a range that iterates over all elements of the
       container, in a container-defined order. The container should
       choose the most convenient and fast method of iteration for $(D
       opSlice()).

       Complexity: $(BIGOH log(n))
     */
    Range opSlice()
    {
        return Range(this, 0, length);
    }

    unittest
    {
        Array!bool a;
        a.insertBack([true, false, true, true]);
        assert(a[].length == 4);
    }

    /**
       Returns a range that iterates the container between two
       specified positions.

       Complexity: $(BIGOH log(n))
     */
    Range opSlice(ulong a, ulong b)
    {
        enforce(a <= b && b <= length);
        return Range(this, a, b);
    }

    unittest
    {
        Array!bool a;
        a.insertBack([true, false, true, true]);
        assert(a[0 .. 2].length == 2);
    }

    /**
       Equivalent to $(D opSlice().front) and $(D opSlice().back),
       respectively.

       Complexity: $(BIGOH log(n))
     */
    @property bool front()
    {
        enforce(!empty);
        return data.ptr[0] & 1;
    }

    /// Ditto
    @property void front(bool value)
    {
        enforce(!empty);
        if (value) data.ptr[0] |= 1;
        else data.ptr[0] &= ~cast(size_t) 1;
    }

    unittest
    {
        Array!bool a;
        a.insertBack([true, false, true, true]);
        assert(a.front);
        a.front = false;
        assert(!a.front);
    }

    /// Ditto
    @property bool back()
    {
        enforce(!empty);
        return data.back & (1u << ((_store._length - 1) % bitsPerWord));
    }

    /// Ditto
    @property void back(bool value)
    {
        enforce(!empty);
        if (value)
        {
            data.back |= (1u << ((_store._length - 1) % bitsPerWord));
        }
        else
        {
            data.back &=
                ~(cast(size_t)1 << ((_store._length - 1) % bitsPerWord));
        }
    }

    unittest
    {
        Array!bool a;
        a.insertBack([true, false, true, true]);
        assert(a.back);
        a.back = false;
        assert(!a.back);
    }

    /**
       Indexing operators yield or modify the value at a specified index.
     */
    bool opIndex(ulong i)
    {
        auto div = cast(size_t) (i / bitsPerWord);
        auto rem = i % bitsPerWord;
        enforce(div < data.length);
        return data.ptr[div] & (1u << rem);
    }
    /// ditto
    void opIndexAssign(bool value, ulong i)
    {
        auto div = cast(size_t) (i / bitsPerWord);
        auto rem = i % bitsPerWord;
        enforce(div < data.length);
        if (value) data.ptr[div] |= (1u << rem);
        else data.ptr[div] &= ~(cast(size_t)1 << rem);
    }
    /// ditto
    void opIndexOpAssign(string op)(bool value, ulong i)
    {
        auto div = cast(size_t) (i / bitsPerWord);
        auto rem = i % bitsPerWord;
        enforce(div < data.length);
        auto oldValue = cast(bool) (data.ptr[div] & (1u << rem));
        // Do the deed
        auto newValue = mixin("oldValue "~op~" value");
        // Write back the value
        if (newValue != oldValue)
        {
            if (newValue) data.ptr[div] |= (1u << rem);
            else data.ptr[div] &= ~(cast(size_t)1 << rem);
        }
    }
    /// Ditto
    T moveAt(ulong i)
    {
        return this[i];
    }

    unittest
    {
        Array!bool a;
        a.insertBack([true, false, true, true]);
        assert(a[0] && !a[1]);
        a[0] &= a[1];
        assert(!a[0]);
    }

    /**
       Returns a new container that's the concatenation of $(D this)
       and its argument.

       Complexity: $(BIGOH n + m), where m is the number of elements
       in $(D stuff)
     */
    Array!bool opBinary(string op, Stuff)(Stuff rhs) if (op == "~")
    {
        auto result = this;
        return result ~= rhs;
    }

    unittest
    {
        Array!bool a;
        a.insertBack([true, false, true, true]);
        Array!bool b;
        b.insertBack([true, true, false, true]);
        assert(equal((a ~ b)[],
                        [true, false, true, true, true, true, false, true]));
    }

    // /// ditto
    // TotalContainer opBinaryRight(Stuff, string op)(Stuff lhs) if (op == "~")
    // {
    //     assert(0);
    // }

    /**
       Forwards to $(D insertAfter(this[], stuff)).
     */
    // @@@BUG@@@
    //ref Array!bool opOpAssign(string op, Stuff)(Stuff stuff) if (op == "~")
    Array!bool opOpAssign(string op, Stuff)(Stuff stuff) if (op == "~")
    {
        static if (is(typeof(stuff[]))) insertBack(stuff[]);
        else insertBack(stuff);
        return this;
    }

    unittest
    {
        Array!bool a;
        a.insertBack([true, false, true, true]);
        Array!bool b;
        a.insertBack([false, true, false, true, true]);
        a ~= b;
        assert(equal(
                    a[],
                    [true, false, true, true, false, true, false, true, true]));
    }

    /**
       Removes all contents from the container. The container decides
       how $(D capacity) is affected.

       Postcondition: $(D empty)

       Complexity: $(BIGOH n)
     */
    void clear()
    {
        this = Array!bool();
    }

    unittest
    {
        Array!bool a;
        a.insertBack([true, false, true, true]);
        a.clear();
        assert(a.capacity == 0);
    }

    /**
       Sets the number of elements in the container to $(D
       newSize). If $(D newSize) is greater than $(D length), the
       added elements are added to the container and initialized with
       $(D ElementType.init).

       Complexity: $(BIGOH abs(n - newLength))

       Postcondition: $(D _length == newLength)
     */
    @property void length(ulong newLength)
    {
        _store.RefCounted.ensureInitialized();
        auto newDataLength =
            to!size_t((newLength + bitsPerWord - 1) / bitsPerWord);
        _store._backend.length = newDataLength;
        _store._length = newLength;
    }

    unittest
    {
        Array!bool a;
        a.length = 1057;
        assert(a.length == 1057);
        foreach (e; a)
        {
            assert(!e);
        }
    }

    /**
       Inserts $(D stuff) in the container. $(D stuff) can be a value
       convertible to $(D ElementType) or a range of objects
       convertible to $(D ElementType).

       The $(D stable) version guarantees that ranges iterating over
       the container are never invalidated. Client code that counts on
       non-invalidating insertion should use $(D stableInsert).

       Returns: The number of elements added.

       Complexity: $(BIGOH m * log(n)), where $(D m) is the number of
       elements in $(D stuff)
     */
    alias insertBack insert;
    ///ditto
    alias insertBack stableInsert;

    /**
       Same as $(D insert(stuff)) and $(D stableInsert(stuff))
       respectively, but relax the complexity constraint to linear.
     */
    alias insertBack linearInsert;
    ///ditto
    alias insertBack stableLinearInsert;

    /**
       Picks one value in the container, removes it from the
       container, and returns it. The stable version behaves the same,
       but guarantees that ranges iterating over the container are
       never invalidated.

       Precondition: $(D !empty)

       Returns: The element removed.

       Complexity: $(BIGOH log(n))
     */
    T removeAny()
    {
        auto result = back();
        removeBack();
        return result;
    }
    /// ditto
    alias removeAny stableRemoveAny;

    unittest
    {
        Array!bool a;
        a.length = 1057;
        assert(!a.removeAny());
        assert(a.length == 1056);
        foreach (e; a)
        {
            assert(!e);
        }
    }

    /**
       Inserts $(D value) to the back of the container. $(D stuff) can
       be a value convertible to $(D ElementType) or a range of
       objects convertible to $(D ElementType). The stable version
       behaves the same, but guarantees that ranges iterating over the
       container are never invalidated.

       Returns: The number of elements inserted

       Complexity: $(BIGOH log(n))
     */
    ulong insertBack(Stuff)(Stuff stuff) if (is(Stuff : bool))
    {
        _store.RefCounted.ensureInitialized();
        auto rem = _store._length % bitsPerWord;
        if (rem)
        {
            // Fits within the current array
            if (stuff)
            {
                data[$ - 1] |= (1u << rem);
            }
            else
            {
                data[$ - 1] &= ~(1u << rem);
            }
        }
        else
        {
            // Need to add more data
            _store._backend.insertBack(stuff);
        }
        ++_store._length;
        return 1;
    }
    /// Ditto
    ulong insertBack(Stuff)(Stuff stuff)
    if (isInputRange!Stuff && is(ElementType!Stuff : bool))
    {
        static if (!hasLength!Stuff) ulong result;
        for (; !stuff.empty; stuff.popFront())
        {
            insertBack(stuff.front);
            static if (!hasLength!Stuff) ++result;
        }
        static if (!hasLength!Stuff) return result;
        else return stuff.length;
    }
    /// ditto
    alias insertBack stableInsertBack;

    /**
       Removes the value at the front or back of the container. The
       stable version behaves the same, but guarantees that ranges
       iterating over the container are never invalidated. The
       optional parameter $(D howMany) instructs removal of that many
       elements. If $(D howMany > n), all elements are removed and no
       exception is thrown.

       Precondition: $(D !empty)

       Complexity: $(BIGOH log(n)).
     */
    void removeBack()
    {
        enforce(_store._length);
        if (_store._length % bitsPerWord)
        {
            // Cool, just decrease the length
            --_store._length;
        }
        else
        {
            // Reduce the allocated space
            --_store._length;
            _store._backend.length = _store._backend.length - 1;
        }
    }
    /// ditto
    alias removeBack stableRemoveBack;

    /**
       Removes $(D howMany) values at the front or back of the
       container. Unlike the unparameterized versions above, these
       functions do not throw if they could not remove $(D howMany)
       elements. Instead, if $(D howMany > n), all elements are
       removed. The returned value is the effective number of elements
       removed. The stable version behaves the same, but guarantees
       that ranges iterating over the container are never invalidated.

       Returns: The number of elements removed

       Complexity: $(BIGOH howMany * log(n)).
     */
    /// ditto
    ulong removeBack(ulong howMany)
    {
        if (howMany >= length)
        {
            howMany = length;
            clear();
        }
        else
        {
            length = length - howMany;
        }
        return howMany;
    }

    unittest
    {
        Array!bool a;
        a.length = 1057;
        assert(a.removeBack(1000) == 1000);
        assert(a.length == 57);
        foreach (e; a)
        {
            assert(!e);
        }
    }

    /**
       Inserts $(D stuff) before, after, or instead range $(D r),
       which must be a valid range previously extracted from this
       container. $(D stuff) can be a value convertible to $(D
       ElementType) or a range of objects convertible to $(D
       ElementType). The stable version behaves the same, but
       guarantees that ranges iterating over the container are never
       invalidated.

       Returns: The number of values inserted.

       Complexity: $(BIGOH n + m), where $(D m) is the length of $(D stuff)
     */
    ulong insertBefore(Stuff)(Range r, Stuff stuff)
    {
        // TODO: make this faster, it moves one bit at a time
        immutable inserted = stableInsertBack(stuff);
        immutable tailLength = length - inserted;
        bringToFront(
            this[r._a .. tailLength],
            this[tailLength .. length]);
        return inserted;
    }
    /// ditto
    alias insertBefore stableInsertBefore;

    unittest
    {
        Array!bool a;
        version (bugxxxx)
        {
            a._store.refCountedDebug = true;
        }
        a.insertBefore(a[], true);
        assert(a.length == 1, text(a.length));
        a.insertBefore(a[], false);
        assert(a.length == 2, text(a.length));
    }

    /// ditto
    ulong insertAfter(Stuff)(Range r, Stuff stuff)
    {
        // TODO: make this faster, it moves one bit at a time
        immutable inserted = stableInsertBack(stuff);
        immutable tailLength = length - inserted;
        bringToFront(
            this[r._b .. tailLength],
            this[tailLength .. length]);
        return inserted;
    }
    /// ditto
    alias insertAfter stableInsertAfter;

    unittest
    {
        Array!bool a;
        a.length = 10;
        a.insertAfter(a[0 .. 5], true);
        assert(a.length == 11, text(a.length));
        assert(a[5]);
    }
    /// ditto
    size_t replace(Stuff)(Range r, Stuff stuff) if (is(Stuff : bool))
    {
        if (!r.empty)
        {
            // There is room
            r.front = stuff;
            r.popFront();
            linearRemove(r);
        }
        else
        {
            // No room, must insert
            insertBefore(r, stuff);
        }
        return 1;
    }
    /// ditto
    alias replace stableReplace;

    unittest
    {
        Array!bool a;
        a.length = 10;
        a.replace(a[3 .. 5], true);
        assert(a.length == 9, text(a.length));
        assert(a[3]);
    }

    /**
       Removes all elements belonging to $(D r), which must be a range
       obtained originally from this container. The stable version
       behaves the same, but guarantees that ranges iterating over the
       container are never invalidated.

       Returns: A range spanning the remaining elements in the container that
       initially were right after $(D r).

       Complexity: $(BIGOH n)
     */
    Range linearRemove(Range r)
    {
        copy(this[r._b .. length], this[r._a .. length]);
        length = length - r.length;
        return this[r._a .. length];
    }
    /// ditto
    alias linearRemove stableLinearRemove;
}

unittest
{
    Array!bool a;
    assert(a.empty);
}
