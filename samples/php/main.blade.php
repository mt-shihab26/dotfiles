@extends('layouts.app')

@section('title', 'Sample')

@section('content')
    <h1>{{ $title }}</h1>

    @if ($people->isEmpty())
        <p>No one here.</p>
    @else
        <ul>
            @foreach ($people as $person)
                <li class="{{ $loop->first ? 'first' : '' }}">Hello, {{ $person->name }}!</li>
            @endforeach
        </ul>
    @endif

    <x-button type="submit" :disabled="$locked">Save</x-button>

    {!! $rawHtml !!}
@endsection
